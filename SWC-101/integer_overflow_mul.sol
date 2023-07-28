//单笔交易溢出
//交易后效果：溢出逃逸到公开可读存储
pragma solidity ^0.4.19;

contract IntegerOverflowMul {
    uint public count = 2;

    function run(uint256 input) public {
        count *= input;
    }
}