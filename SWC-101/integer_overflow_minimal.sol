//单次交易溢出
//事务后效果：溢出转移到公开可读存储

pragma solidity ^0.4.19;

contract IntegerOverflowMinimal {
    uint public count = 1;

    function run(uint256 input) public {
        count -= input;
    }
}