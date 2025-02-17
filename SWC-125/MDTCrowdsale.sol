/*
 * @来源: https://github.com/Arachnid/uscc/blob/master/submissions-2017/philipdaian/MDTCrowdsale.sol
 * @作者: Philip Daian
 */

pragma solidity ^0.4.25;

//import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";
/**
 * @标题 SafeMath
 * @使用安全检查的开发数学运算，在错误时会回滚。
 */
library SafeMath {
    /**
    * @将两个数字相乘，如果溢出则返回反转。
    */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // gas优化：这比要求'a'不为零更便宜，但如果'b'也被测试，这个好处就会丧失。
        // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b);

        return c;
    }

    /**
    * @整数除法是指两个数相除后截断商，如果除数为零，则会返回错误。
    */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // 只有在除以0时，Solidity才会自动断言。
        require(b > 0);
        uint256 c = a / b;
        // 断言(a == b * c + a % b); // 没有情况下不成立的情况

        return c;
    }

    /**
    * @减去两个数字，如果被减数大于减数，则返回溢出。
    */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);
        uint256 c = a - b;

        return c;
    }

    /**
    * @添加了两个数字，在溢出时进行还原。
    */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);

        return c;
    }

    /**
    * @除两个数字并返回余数（无符号整数取模），在除以零时返回。
    */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0);
        return a % b;
    }
}

//import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/ERC20Mintable.sol";

/**
 * @ERC20 接口
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */
interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address who) external view returns (uint256);

    function allowance(address owner, address spender) external view returns (uint256);

    function transfer(address to, uint256 value) external returns (bool);

    function approve(address spender, uint256 value) external returns (bool);

    function transferFrom(address from, address to, uint256 value) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);
}

/**
 * @标准ERC20代币
 *
 * @基本标准代币的开发实现。
 * https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md
 * 首先基于FirstBlood的代码。https://github.com/Firstbloodio/token/blob/master/smart_contract/FirstBloodToken.sol
 *
 * 这个实现会发出额外的Approval事件，允许应用程序通过监听这些事件来重构所有账户的授权状态。请注意，这不是规范要求的，其他符合规范的实现可能不会这样做。
 */
contract ERC20 is IERC20 {
    using SafeMath for uint256;

    mapping (address => uint256) private _balances;

    mapping (address => mapping (address => uint256)) private _allowed;

    uint256 private _totalSupply;

    /**
    * @存在的令牌总数量
    */
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    /**
    * @获取指定地址的余额。
    * @param owner 要查询余额的地址。
    * @return 一个表示该地址拥有的金额的 uint256。
    */
    function balanceOf(address owner) public view returns (uint256) {
        return _balances[owner];
    }

    /**
     * @用于检查所有者允许给支出者的代币数量的函数。
     * @param owner 地址 拥有资金的地址。
     * @param spender 地址 将花费资金的地址。
     * @return 一个 uint256，指定仍然可用于支出者的代币数量。
     */
    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowed[owner][spender];
    }

    /**
    * @为指定地址转移令牌
    * @param to 转移至的地址。
    * @param value 要转移的数量。
    */
    function transfer(address to, uint256 value) public returns (bool) {
        _transfer(msg.sender, to, value);
        return true;
    }

    /**
     * @批准已通过的地址代表msg.sender花费指定数量的代币。
     * 请注意，使用此方法更改额度存在着某人可能通过不幸的交易顺序同时使用旧的和新的额度的风险。
    * 缓解此竞争条件的一种可能解决方案是首先将支出者的额度减少为0，然后再设置所需的值：
    * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
    * @param spender 将花费资金的地址。
    * @param value 要花费的代币数量。
     */
    function approve(address spender, uint256 value) public returns (bool) {
        require(spender != address(0));

        _allowed[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    /**
     * @将代币从一个地址转移到另一个地址。
     * 请注意，虽然此函数会发出一个Approval事件，但根据规范并不需要这样做，其他符合规范的实现可能不会发出该事件。
     * @param from地址 你希望从中发送代币的地址
     * @param to地址 你希望转移到的地址
     * @param value uint256 要转移的代币数量
     */
    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        _allowed[from][msg.sender] = _allowed[from][msg.sender].sub(value);
        _transfer(from, to, value);
        emit Approval(from, msg.sender, _allowed[from][msg.sender]);
        return true;
    }

    /**
     * @增加所有者允许给支出者的代币数量。
     * 当allowed_[_spender] == 0时，应调用approve。为了增加允许的值，最好使用此函数以避免2次调用（并等待第一笔交易被挖掘）
     * 来自MonolithDAO Token.sol
     * 发出一个Approval事件。
     * @param spender 将花费资金的地址。
     * @param addedValue 要增加的额度金额。
     */
    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        require(spender != address(0));

        _allowed[msg.sender][spender] = _allowed[msg.sender][spender].add(addedValue);
        emit Approval(msg.sender, spender, _allowed[msg.sender][spender]);
        return true;
    }

    /**
     * @减少所有者允许给花费者的代币数量。
     * 当allowed_[_spender] == 0时，应调用approve函数。为了减少允许值，最好使用此函数以避免2次调用（并等待第一笔交易被确认）。
     * 来自MonolithDAO Token.sol
     * 发出一个Approval事件。
     * @param spender 将花费资金的地址。
     * @param subtractedValue 要减少授权额度的代币数量。
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
        require(spender != address(0));

        _allowed[msg.sender][spender] = _allowed[msg.sender][spender].sub(subtractedValue);
        emit Approval(msg.sender, spender, _allowed[msg.sender][spender]);
        return true;
    }

    /**
    * @转移指定地址的令牌
    * @param from 要转移的地址。
    * @param to 要转移到的地址。
    * @param value 要转移的数量。
    */
    function _transfer(address from, address to, uint256 value) internal {
        require(to != address(0));

        _balances[from] = _balances[from].sub(value);
        _balances[to] = _balances[to].add(value);
        emit Transfer(from, to, value);
    }

    /**
     * @内部函数，用于铸造一定数量的代币并分配给一个账户。这个函数封装了余额修改的过程，从而正确地触发事件。
     * @param account 将接收创建的代币的账户。
     * @param value 将要创建的数量。
     */
    function _mint(address account, uint256 value) internal {
        require(account != address(0));

        _totalSupply = _totalSupply.add(value);
        _balances[account] = _balances[account].add(value);
        emit Transfer(address(0), account, value);
    }

    /**
     * @内部函数，用于烧掉给定账户的一定数量的代币。
     * @param account 将被烧掉代币的账户。
     * @param value 将被烧掉的数量。
     */
    function _burn(address account, uint256 value) internal {
        require(account != address(0));

        _totalSupply = _totalSupply.sub(value);
        _balances[account] = _balances[account].sub(value);
        emit Transfer(account, address(0), value);
    }

    /**
     * @翻译：内部函数，用于燃烧给定账户的一定数量代币，从发送者对该账户的授权中扣除。使用内部的燃烧函数。
     * 触发一个Approval事件（反映减少的授权）。
     * account参数是将要燃烧代币的账户，
     * value参数是将要燃烧的数量。
     */
    function _burnFrom(address account, uint256 value) internal {
        _allowed[account][msg.sender] = _allowed[account][msg.sender].sub(value);
        _burn(account, value);
        emit Approval(account, msg.sender, _allowed[account][msg.sender]);
    }
}

/**
 * @标题 Roles
 * @ 用于管理分配给角色的地址的库。
 */
library Roles {
    struct Role {
        mapping (address => bool) bearer;
    }

    /**
     * @将一个账户授予此角色的访问权限。
     */
    function add(Role storage role, address account) internal {
        require(account != address(0));
        require(!has(role, account));

        role.bearer[account] = true;
    }

    /**
     * @将账户的访问权限从此角色中移除
     */
    function remove(Role storage role, address account) internal {
        require(account != address(0));
        require(has(role, account));

        role.bearer[account] = false;
    }

    /**
     * @检查是否拥有此角色
     * @返回 bool
     */
    function has(Role storage role, address account) internal view returns (bool) {
        require(account != address(0));
        return role.bearer[account];
    }
}

contract MinterRole {
    using Roles for Roles.Role;

    event MinterAdded(address indexed account);
    event MinterRemoved(address indexed account);

    Roles.Role private _minters;

    constructor () internal {
        _addMinter(msg.sender);
    }

    modifier onlyMinter() {
        require(isMinter(msg.sender));
        _;
    }

    function isMinter(address account) public view returns (bool) {
        return _minters.has(account);
    }

    function addMinter(address account) public onlyMinter {
        _addMinter(account);
    }

    function renounceMinter() public {
        _removeMinter(msg.sender);
    }

    function _addMinter(address account) internal {
        _minters.add(account);
        emit MinterAdded(account);
    }

    function _removeMinter(address account) internal {
        _minters.remove(account);
        emit MinterRemoved(account);
    }
}

/**
 * @标题 ERC20Mintable
 * @ ERC20铸币逻辑
 */
contract ERC20Mintable is ERC20, MinterRole {
    /**
     * @dev 创建代币的函数
     * @param to 将接收铸造代币的地址。
     * @param value 要铸造的代币数量。
     * @return 一个布尔值，指示操作是否成功。
     */
    function mint(address to, uint256 value) public onlyMinter returns (bool) {
        _mint(to, value);
        return true;
    }
}
/**
 * @标题 Crowdsale
 * @dev Crowdsale是一个用于管理代币众筹的基础合约。
 * 众筹活动有一个开始和结束区块，在这期间，投资者可以购买代币，
 * 众筹活动将根据以太兑换代币的比率分配给他们代币。
 * 收集到的资金将在到达时转发到一个钱包。
 */
contract Crowdsale {
    using SafeMath for uint256;

    // 正在出售的代币
    ERC20Mintable public token;

    // 开始和结束的区块，允许进行投资（包括起始和结束）。
    uint256 public startBlock;
    uint256 public endBlock;

    // 收款地址
    address public wallet;

    // 每个wei买家获得多少令牌单位
    uint256 public rate;

    // 筹集到的资金金额（以wei为单位）
    uint256 public weiRaised;

    /**
    * 购买令牌日志事件
    * @param 购买者：支付代币的人
    * @param 受益人：获得代币的人
    * @param 价值：购买支付的以太
    * @param 数量：购买的代币数量
    */
    event TokenPurchase(address indexed purchaser, address indexed beneficiary, uint256 value, uint256 amount);

    function Crowdsale(uint256 _startBlock, uint256 _endBlock, uint256 _rate, address _wallet) {
        require(_startBlock >= block.number);
        require(_endBlock >= _startBlock);
        require(_rate > 0);
        require(_wallet != 0x0);

        token = createTokenContract();
        startBlock = _startBlock;
        endBlock = _endBlock;
        rate = _rate;
        wallet = _wallet;
    }

    // 创建要出售的令牌。
    // 重写此方法以进行特定可铸造令牌的众筹销售。
    function createTokenContract() internal returns (ERC20Mintable) {
        return new ERC20Mintable();
    }


    // 回退函数可以用来购买代币。
    function () payable {
        buyTokens(msg.sender);
    }

    // 低级令牌购买功能
    function buyTokens(address beneficiary) payable {
        require(beneficiary != 0x0);
        require(validPurchase());

        uint256 weiAmount = msg.value;

        // 计算将要创建的代币数量
        uint256 tokens = weiAmount.mul(rate);

        // 更新状态
        weiRaised = weiRaised.add(weiAmount);

        token.mint(beneficiary, tokens);
        TokenPurchase(msg.sender, beneficiary, weiAmount, tokens);

        forwardFunds();
    }

    // 将以太发送到资金收集钱包
    // 重写以创建自定义的资金转发机制
    function forwardFunds() internal {
        wallet.transfer(msg.value);
    }

    // @如果交易可以购买代币，则返回true。
    function validPurchase() internal constant returns (bool) {
        uint256 current = block.number;
        bool withinPeriod = current >= startBlock && current <= endBlock;
        bool nonZeroPurchase = msg.value != 0;
        return withinPeriod && nonZeroPurchase;
    }

    // @如果众筹活动已结束，则返回true。
    function hasEnded() public constant returns (bool) {
        return block.number > endBlock;
    }
}

/**
 * @标题 CappedCrowdsale
 * @dev 众筹的扩展，募集资金上限设定
 */
 contract CappedCrowdsale is Crowdsale {
    using SafeMath for uint256;
    uint256 public cap;

    function CappedCrowdsale(uint256 _cap) {
        require(_cap > 0);
        cap = _cap;
    }

    // 重写Crowdsale#validPurchase以添加额外的上限逻辑
    // @return 如果投资者可以购买，返回true
    function validPurchase() internal constant returns (bool) {
        bool withinCap = weiRaised.add(msg.value) <= cap;
        return super.validPurchase() && withinCap;
    }

    // 重写Crowdsale#hasEnded函数以添加上限逻辑
    // @return 如果众筹活动已结束，则返回true
    function hasEnded() public constant returns (bool) {
        bool capReached = weiRaised >= cap;
        return super.hasEnded() || capReached;
    }
}

/**
 * @标题 WhitelistedCrowdsale
 * @dev 带有投资者白名单的众筹合约扩展，在开始区块之前可以购买
 */
contract WhitelistedCrowdsale is Crowdsale {
    using SafeMath for uint256;

    mapping (address => bool) public whitelist;

    function addToWhitelist(address addr) {
        require(msg.sender != address(this));
        whitelist[addr] = true;
    }

    // 覆盖Crowdsale＃validPurchase以添加额外的白名单逻辑
    // @return 如果投资者此刻可以购买，则返回true
    function validPurchase() internal constant returns (bool) {
        return super.validPurchase() || (whitelist[msg.sender] && !hasEnded());
    }

}

contract MDTCrowdsale is CappedCrowdsale, WhitelistedCrowdsale {

    function MDTCrowdsale()
    CappedCrowdsale(50000000000000000000000)
    Crowdsale(block.number, block.number + 100000, 1, msg.sender) { // Wallet is the contract creator, to whom funds will be sent
        addToWhitelist(msg.sender);
        addToWhitelist(0x0d5bda9db5dd36278c6a40683960ba58cac0149b);
        addToWhitelist(0x1b6ddc637c24305b354d7c337f9126f68aad4886);
    }

}