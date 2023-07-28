pragma solidity ^0.4.24;

/* 用户可以添加以太并提取。
   构造函数命名错误，因此任何人都可以成为“创建者”并提取所有资金。
*/

contract Wallet {
    address creator;

    mapping(address => uint256) balances;

    function initWallet() public {
        creator = msg.sender;
    }

    function deposit() public payable {
        assert(balances[msg.sender] + msg.value > balances[msg.sender]);
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(amount <= balances[msg.sender]);
        msg.sender.transfer(amount);
        balances[msg.sender] -= amount;
    }

    // 在紧急情况下，所有者可以将所有资金迁移到不同的地址。

    function migrateTo(address to) public {
        require(creator == msg.sender);
        to.transfer(this.balance);
    }

}