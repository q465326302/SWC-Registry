pragma solidity ^0.5.0;

contract UnusedVariables {
    int a = 1;

    // y未被使用
    function unusedArg(int x, int y) public view returns (int z) {
        z = x + a;  
    }

    // n没有被报告，它是另一个SWC类别的一部分。
    function unusedReturn(int x, int y) public pure returns (int m, int n, int o) {
        m = y - x;
        o = m/2;
    }

    // x没有被访问
    function neverAccessed(int test) public pure returns (int) {
        int z = 10;

        if (test > z) {
            // x is not used
            int x = test - z;

            return test - z;
        }

        return z;
    }

    function tupleAssignment(int p) public returns (int q, int r){
        (q, , r) = unusedReturn(p,2);

    }


}