// sol钱包
// 多重签名，每日限额的账户代理/钱包。
// 作者：
// Gav Wood <g@ethdev.com>
// 可继承的“属性”合约，通过要求单个或关键的一组指定所有者的同意来保护方法。
// 用法：
// 使用修饰符onlyowner（只有所有者自己）或onlymanyowners（哈希值），在执行内部代码之前，必须由一组所有者（在构造函数中指定，可修改）中的一定数量（在构造函数中指定）提供相同的哈希值。

pragma solidity ^0.4.9;

contract WalletEvents {
 // 事件

// 这个合约只有六种类型的事件：它可以接受一个确认，此时我们会记录所有者和操作（哈希）与之一起。
  event Confirmation(address owner, bytes32 operation);
  event Revoke(address owner, bytes32 operation);

  // 一些其他情况下会发生所有者更改的情况。
  event OwnerChanged(address oldOwner, address newOwner);
  event OwnerAdded(address newOwner);
  event OwnerRemoved(address oldOwner);

  // 如果所需的签名发生变化，则发出最后一个签名。
  event RequirementChanged(uint newRequirement);

  // 资金已到账到钱包（记录金额）。
  event Deposit(address _from, uint value);
  // 单笔交易从钱包中出去（记录谁签署了交易，金额以及交易去向）。
  event SingleTransact(address owner, uint value, address to, bytes data, address created);
  // 多签交易离开钱包（记录最后一次谁签署了它，操作哈希，金额以及去向）。
  event MultiTransact(address owner, bytes32 operation, uint value, address to, bytes data, address created);
  // 交易仍需确认。
  event ConfirmationNeeded(bytes32 operation, address initiator, uint value, address to, bytes data);
}

contract WalletAbi {
  // 撤销先前对给定操作的确认
  function revoke(bytes32 _operation) external;

  // 替换一个所有者`_from`为另一个所有者`_to`。
  function changeOwner(address _from, address _to) external;

  function addOwner(address _owner) external;

  function removeOwner(address _owner) external;

  function changeRequirement(uint _newRequired) external;

  function isOwner(address _addr) constant returns (bool);

  function hasConfirmed(bytes32 _operation, address _owner) external constant returns (bool);

  // 重新设置每日限额。需要许多所有者确认。不会改变今天已经花费的金额。
  function setDailyLimit(uint _newLimit) external;

  function execute(address _to, uint _value, bytes _data) external returns (bytes32 o_hash);
  function confirm(bytes32 _h) returns (bool o_success);
}

contract WalletLibrary is WalletEvents {
  // 类型

  // 用于表示待处理操作状态的结构体。
  struct PendingState {
    uint yetNeeded;
    uint ownersDone;
    uint index;
  }

  // 记住交易细节的交易结构，以防需要在以后的调用中保存。
  struct Transaction {
    address to;
    uint value;
    bytes data;
  }

  // 修饰符

  // 简单的单签名函数修饰符。
  modifier onlyowner {
    if (isOwner(msg.sender))
      _;
  }
  // 多签名功能修饰符：操作必须具有内在哈希，以便后续的尝试可以被视为相同的基础操作，并因此计为确认。
  modifier onlymanyowners(bytes32 _operation) {
    if (confirmAndCheck(_operation))
      _;
  }

  // 方法

  // 当没有其他函数匹配时，会调用该函数。
  function() payable {
    // just being sent some cash?
    if (msg.value > 0)
      Deposit(msg.sender, msg.value);
  }

  // 构造函数给出了执行受保护的“onlymanyowners”交易所需的签名数量，以及能够确认这些交易的地址的选择。
  function initMultiowned(address[] _owners, uint _required) only_uninitialized {
    m_numOwners = _owners.length + 1;
    m_owners[1] = uint(msg.sender);
    m_ownerIndex[uint(msg.sender)] = 1;
    for (uint i = 0; i < _owners.length; ++i)
    {
      m_owners[2 + i] = uint(_owners[i]);
      m_ownerIndex[uint(_owners[i])] = 2 + i;
    }
    m_required = _required;
  }

  // 撤销之前对给定操作的确认。
  function revoke(bytes32 _operation) external {
    uint ownerIndex = m_ownerIndex[uint(msg.sender)];
    // 确保他们是所有者
    if (ownerIndex == 0) return;
    uint ownerIndexBit = 2**ownerIndex;
    var pending = m_pending[_operation];
    if (pending.ownersDone & ownerIndexBit > 0) {
      pending.yetNeeded++;
      pending.ownersDone -= ownerIndexBit;
      Revoke(msg.sender, _operation);
    }
  }

  // 将一个所有者`_from`替换为另一个`_to`。
  function changeOwner(address _from, address _to) onlymanyowners(sha3(msg.data)) external {
    if (isOwner(_to)) return;
    uint ownerIndex = m_ownerIndex[uint(_from)];
    if (ownerIndex == 0) return;

    clearPending();
    m_owners[ownerIndex] = uint(_to);
    m_ownerIndex[uint(_from)] = 0;
    m_ownerIndex[uint(_to)] = ownerIndex;
    OwnerChanged(_from, _to);
  }

  function addOwner(address _owner) onlymanyowners(sha3(msg.data)) external {
    if (isOwner(_owner)) return;

    clearPending();
    if (m_numOwners >= c_maxOwners)
      reorganizeOwners();
    if (m_numOwners >= c_maxOwners)
      return;
    m_numOwners++;
    m_owners[m_numOwners] = uint(_owner);
    m_ownerIndex[uint(_owner)] = m_numOwners;
    OwnerAdded(_owner);
  }

  function removeOwner(address _owner) onlymanyowners(sha3(msg.data)) external {
    uint ownerIndex = m_ownerIndex[uint(_owner)];
    if (ownerIndex == 0) return;
    if (m_required > m_numOwners - 1) return;

    m_owners[ownerIndex] = 0;
    m_ownerIndex[uint(_owner)] = 0;
    clearPending();
    reorganizeOwners(); //make sure m_numOwner is equal to the number of owners and always points to the optimal free slot
    OwnerRemoved(_owner);
  }

  function changeRequirement(uint _newRequired) onlymanyowners(sha3(msg.data)) external {
    if (_newRequired > m_numOwners) return;
    m_required = _newRequired;
    clearPending();
    RequirementChanged(_newRequired);
  }

  // 按照0索引位置获取所有者（使用numOwners作为计数）
  function getOwner(uint ownerIndex) external constant returns (address) {
    return address(m_owners[ownerIndex + 1]);
  }

  function isOwner(address _addr) constant returns (bool) {
    return m_ownerIndex[uint(_addr)] > 0;
  }

  function hasConfirmed(bytes32 _operation, address _owner) external constant returns (bool) {
    var pending = m_pending[_operation];
    uint ownerIndex = m_ownerIndex[uint(_owner)];

    // 确保他们是所有者
    if (ownerIndex == 0) return false;

    // 确定为此所有者设置的位。
    uint ownerIndexBit = 2**ownerIndex;
    return !(pending.ownersDone & ownerIndexBit == 0);
  }

  // 构造函数 - 存储初始每日限额并记录当前日期的索引。
  function initDaylimit(uint _limit) only_uninitialized {
    m_dailyLimit = _limit;
    m_lastDay = today();
  }
  // 重新设置每日限额。需要许多所有者的确认。不会改变今天已经花费的金额。
  function setDailyLimit(uint _newLimit) onlymanyowners(sha3(msg.data)) external {
    m_dailyLimit = _newLimit;
  }
  // 重设了今天已经花费的金额。需要很多业主的确认。
  function resetSpentToday() onlymanyowners(sha3(msg.data)) external {
    m_spentToday = 0;
  }

  // 除非合同尚未初始化，否则不要抛出异常。
  modifier only_uninitialized { if (m_numOwners > 0) throw; _; }

  // 构造函数 - 只需将所有者数组传递给多所有权合约和限制传递给每日限额合约。
  function initWallet(address[] _owners, uint _required, uint _daylimit) only_uninitialized {
    initDaylimit(_daylimit);
    initMultiowned(_owners, _required);
  }

  // 将合约发送到`_to`以结束合约。
  function kill(address _to) onlymanyowners(sha3(msg.data)) external {
    suicide(_to);
  }

  // 外部可见的交易入口点。如果低于每日消费限额，则立即执行交易。
  //如果不是，则进入多签过程。我们在返回时提供一个哈希，以允许发送者提供其他确认的快捷方式（允许他们避免复制_to、_value和_data参数）。无论如何，他们仍然有使用它们的选择。

  function execute(address _to, uint _value, bytes _data) external onlyowner returns (bytes32 o_hash) {
    // 首先，利用这个机会检查我们是否低于每日限额。
    if ((_data.length == 0 && underLimit(_value)) || m_required == 1) {
      // 是的 - 只需执行该call。
      address created;
      if (_to == 0) {
        created = create(_value, _data);
      } else {
        if (!_to.call.value(_value)(_data))
          throw;
      }
      SingleTransact(msg.sender, _value, _to, _data, created);
    } else {
      // 确定我们的操作哈希。
      o_hash = sha3(msg.data, block.number);
      // 如果是新的，就存储起来。
      if (m_txs[o_hash].to == 0 && m_txs[o_hash].value == 0 && m_txs[o_hash].data.length == 0) {
        m_txs[o_hash].to = _to;
        m_txs[o_hash].value = _value;
        m_txs[o_hash].data = _data;
      }
      if (!confirm(o_hash)) {
        ConfirmationNeeded(o_hash, msg.sender, _value, _to, _data);
      }
    }
  }

  function create(uint _value, bytes _code) internal returns (address o_addr) {
    /*
    assembly {
      o_addr := create(_value, add(_code, 0x20), mload(_code))
      jumpi(invalidJumpLabel, iszero(extcodesize(o_addr)))
    }
    */
  }

  // 通过哈希确认交易。我们使用先前的交易映射表m_txs来确定提供的哈希的交易主体。
  function confirm(bytes32 _h) onlymanyowners(_h) returns (bool o_success) {
    if (m_txs[_h].to != 0 || m_txs[_h].value != 0 || m_txs[_h].data.length != 0) {
      address created;
      if (m_txs[_h].to == 0) {
        created = create(m_txs[_h].value, m_txs[_h].data);
      } else {
        if (!m_txs[_h].to.call.value(m_txs[_h].value)(m_txs[_h].data))
          throw;
      }

      MultiTransact(msg.sender, _h, m_txs[_h].value, m_txs[_h].to, m_txs[_h].data, created);
      delete m_txs[_h];
      return true;
    }
  }

  // 内部方法

  function confirmAndCheck(bytes32 _operation) internal returns (bool) {
    // 确定当前发送者的索引是什么：
    uint ownerIndex = m_ownerIndex[uint(msg.sender)];
    // 确保他们是业主
    if (ownerIndex == 0) return;

    var pending = m_pending[_operation];
    // 如果我们尚未在此操作上工作，请切换并重置确认状态。
    if (pending.yetNeeded == 0) {
      // 重置所需确认的计数。
      pending.yetNeeded = m_required;
      // 重置已确认的所有所有者（无）- 将我们的位图设置为0。
      pending.ownersDone = 0;
      pending.index = m_pendingIndex.length++;
      m_pendingIndex[pending.index] = _operation;
    }
    // 确定为该所有者设置的位。
    uint ownerIndexBit = 2 ** ownerIndex;
    // 确保我们（消息发送者）之前没有确认过此操作。
    if (pending.ownersDone & ownerIndexBit == 0) {
      Confirmation(msg.sender, _operation);
      // 检查计数是否足够继续。
      if (pending.yetNeeded <= 1) {
        // 足够的确认：重置并运行内部。
        delete m_pendingIndex[m_pending[_operation].index];
        delete m_pending[_operation];
        return true;
      }
      else
      {
        // 不够：记录下这位特定业主的确认。
        pending.yetNeeded--;
        pending.ownersDone |= ownerIndexBit;
      }
    }
  }

  function reorganizeOwners() private {
    uint free = 1;
    while (free < m_numOwners)
    {
      while (free < m_numOwners && m_owners[free] != 0) free++;
      while (m_numOwners > 1 && m_owners[m_numOwners] == 0) m_numOwners--;
      if (free < m_numOwners && m_owners[m_numOwners] != 0 && m_owners[free] == 0)
      {
        m_owners[free] = m_owners[m_numOwners];
        m_ownerIndex[m_owners[free]] = free;
        m_owners[m_numOwners] = 0;
      }
    }
  }

  // 检查今天的每日限额中是否至少还剩下 `_value`。如果有，则减去该金额并返回 true。否则，只返回 false。
  function underLimit(uint _value) internal onlyowner returns (bool) {
    // reset the spend limit if we're on a different day to last time.
    if (today() > m_lastDay) {
      m_spentToday = 0;
      m_lastDay = today();
    }
    // 检查是否还有足够的剩余量 - 如果有，则进行减法并返回true。
    // 溢出保护                     // 每日限额检查
    if (m_spentToday + _value >= m_spentToday && m_spentToday + _value <= m_dailyLimit) {
      m_spentToday += _value;
      return true;
    }
    return false;
  }

  // 决定今天指数的因素。
  function today() private constant returns (uint) { return now / 1 days; }

  function clearPending() internal {
    uint length = m_pendingIndex.length;

    for (uint i = 0; i < length; ++i) {
      delete m_txs[m_pendingIndex[i]];

      if (m_pendingIndex[i] != 0)
        delete m_pending[m_pendingIndex[i]];
    }

    delete m_pendingIndex;
  }

  // FIELDS
  address constant _walletLibrary = 0xcafecafecafecafecafecafecafecafecafecafe;

  // 在运行之前必须确认相同操作的所有者数量。
  uint public m_required;
  // 指针用于在m_owners中找到一个空闲槽位。
  uint public m_numOwners;

  uint public m_dailyLimit;
  uint public m_spentToday;
  uint public m_lastDay;

  // 所有者列表
  uint[256] m_owners;

  uint constant c_maxOwners = 250;
  // 在所有者列表中创建索引以允许反向查找。
  mapping(uint => uint) m_ownerIndex;
  // 正在进行的操作。
  mapping(bytes32 => PendingState) m_pending;
  bytes32[] m_pendingIndex;

  // 目前我们有的待处理交易。
  mapping (bytes32 => Transaction) m_txs;
}