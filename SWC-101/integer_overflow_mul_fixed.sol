//单笔交易溢出
//事务后效果：溢出泄漏到可公开读取的存储器中
//安全版本

pragma solidity ^0.4.19;

contract IntegerOverflowMul {
    uint public count = 2;

    function run(uint256 input) public {
        count = mul(count, input);
    }

    //来自SafeMath
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
      // Gas优化：这比要求'a'不为零要便宜，但如果'b'也被测试，则会丧失这种好处。
      // 参见：https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
      if (a == 0) {
        return 0;
      }

      uint256 c = a * b;
      require(c / a == b);

      return c;
    }
}