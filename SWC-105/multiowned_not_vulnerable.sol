pragma solidity ^0.4.23;

/**
 * @多个所有者
 */
contract MultiOwnable {
  address public root;
  mapping (address => address) public owners; // owner => parent of owner

  /**
  * @Ownable构造函数将合约的原始“owner”设置为发送者的帐户。
  */
  constructor() public {
    root = msg.sender;
    owners[root] = root;
  }

  /**
  * @如果由非所有者账户调用，则会引发异常。
  */
  modifier onlyOwner() {
    require(owners[msg.sender] != 0);
    _;
  }

  /**
  * @添加新的所有者
  * 注意这里使用了"onlyOwner"修饰符。
  */ 
  function newOwner(address _owner) onlyOwner external returns (bool) {
    require(_owner != 0);
    owners[_owner] = msg.sender;
    return true;
  }

  /**
    * @删除所有者
    */
  function deleteOwner(address _owner) onlyOwner external returns (bool) {
    require(owners[_owner] == msg.sender || (owners[_owner] != 0 && msg.sender == root));
    owners[_owner] = 0;
    return true;
  }
}

contract TestContract is MultiOwnable {

  function withdrawAll() onlyOwner {
    msg.sender.transfer(this.balance);
  }

  function() payable {
  }

}