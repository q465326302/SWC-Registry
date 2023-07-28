/*
 * @source: https://github.com/ConsenSys/evm-analyzer-benchmark-suite
 * @author: Suhabe Bugrara
 */
//多事务，单函数
//溢出不可行因为算术指令不可达

pragma solidity ^0.4.23;

contract IntegerOverflowMultiTxOneFuncInfeasible {
    uint256 private initialized = 0;
    uint256 public count = 1;

    function run(uint256 input) public {
        if (initialized == 0) {
            return;
        }

        count -= input;
    }
}