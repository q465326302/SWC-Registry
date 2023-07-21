pragma solidity ^0.5.0;

contract DepositBox {
    mapping(address => uint) balance;

    // 接受存款
    function deposit(uint amount) public payable {
        require(msg.value == amount, 'incorrect amount');
        // Should update user balance
        balance[msg.sender] = amount;
    }
}