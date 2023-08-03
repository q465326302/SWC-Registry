pragma solidity ^0.5.0;

contract DepositBox {
    mapping(address => uint) balance;

    // 接受存款
    function deposit(uint amount) public payable {
        require(msg.value == amount, 'incorrect amount');
        // 应更新用户余额
        balance[msg.sender] = amount;
    }
}