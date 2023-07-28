pragma solidity ^0.4.24;

/* 用户可以添加付款和提取以太。
   不幸的是，开发者在“withdraw（）”中使用了错误的比较运算符。
   任何人都可以提取任意数量的以太 :()
*/

contract Wallet {
    address creator;

    mapping(address => uint256) balances;

    constructor() public {
        creator = msg.sender;
    }

    function deposit() public payable {
        assert(balances[msg.sender] + msg.value > balances[msg.sender]);
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(amount >= balances[msg.sender]);
        msg.sender.transfer(amount);
        balances[msg.sender] -= amount;
    }

    //在紧急情况下，所有者可以将所有资金迁移到不同的地址。

    function migrateTo(address to) public {
        require(creator == msg.sender);
        to.transfer(this.balance);
    }

}