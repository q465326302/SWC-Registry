/*
 * @来源: https://github.com/ConsenSys/evm-analyzer-benchmark-suite
 * @作者: Suhabe Bugrara
 */

//多事务，单函数
//可达算术指令（安全）

pragma solidity ^0.4.23;

contract IntegerOverflowMultiTxOneFuncFeasible {

    uint256 private initialized = 0;
    uint256 public count = 1;

    function run(uint256 input) public {
        if (initialized == 0) {
            initialized = 1;
            return;
        }

        count = sub(count, input);
    }

    //来自SafeMath
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);//SafeMath在这里使用assert
        return a - b;
    }
}