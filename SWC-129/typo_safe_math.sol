pragma solidity ^0.4.25;

/** 来源于OpenZeppelin的github
 * @标题 SafeMath
 * @使用安全检查的数学操作，在错误时进行回退。
 */
library SafeMath {

  /**
  * @开发者编写的程序可以将两个数字相乘，当结果溢出时会进行逆转。
  */
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    // 气体优化：这比要求'a'不为零更便宜，但如果'b'也被测试，则会失去这个好处。
    // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
    if (a == 0) {
      return 0;
    }

    uint256 c = a * b;
    require(c / a == b);

    return c;
  }

  /**
  * @整数相除，截断商，当被除数为零时返回。
  */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b > 0); // 在 Solidity 中，只有在除以 0 时才会自动进行断言。
    uint256 c = a / b;
    // assert(a == b * c + a % b); // 没有任何情况下这个不成立

    return c;
  }

  /**
  * @开发者编写了一个函数，用于计算两个数的差。如果被减数大于减数，函数会返回一个错误值。
  */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b <= a);
    uint256 c = a - b;

    return c;
  }

  /**
  * @开发人员将两个数字相加，在溢出时进行还原。
  */
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    require(c >= a);

    return c;
  }

  /**
  * @除两个数字并返回余数（无符号整数模运算），当除以零时返回错误。
  */
  function mod(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b != 0);
    return a % b;
  }
}


contract TypoSafeMath {

    using SafeMath for uint256;
    uint256 public numberOne = 1;
    bool public win = false;

    function addOne() public {
        numberOne =+ 1;
    }

    function addOneCorrect() public {
        numberOne += 1;
    }

    function addOneSafeMath() public  {
        numberOne = numberOne.add(1);
    }

    function iWin() public {
        if(!win && numberOne>3) {
            win = true;
        }
    }
}