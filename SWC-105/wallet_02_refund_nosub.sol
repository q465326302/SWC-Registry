pragma solidity ^0.4.24;

/* 用户可以添加以太并提取以太。
   不幸的是，开发者在调用refund()时忘记将用户的余额设置为0。
   攻击者可以支付少量的以太，并反复调用refund()来清空合约。
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
        require(amount <= balances[msg.sender]);
        msg.sender.transfer(amount);
        balances[msg.sender] -= amount;
    }

    function refund() public {
        msg.sender.transfer(balances[msg.sender]);
    }

    // 在紧急情况下，所有者可以将所有资金迁移到不同的地址。

    function migrateTo(address to) public {
        require(creator == msg.sender);
        to.transfer(this.balance);
    }

}