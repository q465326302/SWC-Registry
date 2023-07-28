//单笔交易溢出
//交易后效果：溢出逃逸到公开可读存储
//安全版本

pragma solidity ^0.4.19;

contract IntegerOverflowMinimal {
    uint public count = 1;

    function run(uint256 input) public {
        count = sub(count,input);
    }

    //来自SafeMath
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);//SafeMath在这里使用assert
        return a - b;
    }
}