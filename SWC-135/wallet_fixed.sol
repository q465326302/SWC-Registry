/*
 * @作者: Kaden Zipfel
 */

pragma solidity ^0.5.0;

contract Wallet {
    mapping(address => uint) balance;

    // 在合约中存入资金
    function deposit(uint amount) public payable {
        require(msg.value == amount, 'msg.value must be equal to amount');
        balance[msg.sender] = amount;
    }

    // 从合约中提取资金
    function withdraw(uint amount) public {
        require(amount <= balance[msg.sender], 'amount must be less than balance');

        uint previousBalance = balance[msg.sender];
        balance[msg.sender] = previousBalance - amount;

        // 尝试将金额从合约发送给消息发送者
        (bool success, ) = msg.sender.call.value(amount)("");
        require(success, 'transfer failed');
    }
}