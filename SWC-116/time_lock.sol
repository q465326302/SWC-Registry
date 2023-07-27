/*
 * @author: Kaden Zipfel
 */

pragma solidity ^0.5.0;

contract TimeLock {
    struct User {
        uint amount; // 锁定金额（以以太计）
        uint unlockBlock; // 解锁以太坊的最小区块
    }

    mapping(address => User) private users;

    // 令牌应该在指定的确切时间内被锁定
    function lockEth(uint _time, uint _amount) public payable {
        require(msg.value == _amount, 'must send exact amount');
        users[msg.sender].unlockBlock = block.number + (_time / 14);
        users[msg.sender].amount = _amount;
    }

    // 如果锁定期已过，可以提取代币。
    function withdraw() public {
        require(users[msg.sender].amount > 0, 'no amount locked');
        require(block.number >= users[msg.sender].unlockBlock, 'lock period not over');

        uint amount = users[msg.sender].amount;
        users[msg.sender].amount = 0;
        (bool success, ) = msg.sender.call.value(amount)("");
        require(success, 'transfer failed');
    }
}