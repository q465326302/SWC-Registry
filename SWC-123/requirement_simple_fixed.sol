pragma solidity ^0.4.25;

contract Bar {
    Foo private f = new Foo();
    function doubleBaz() public view returns (int256) {
        return 2 * f.baz(1); //将外部合约更改为不满足过于严格的要求。
    }
}

contract Foo {
    function baz(int256 x) public pure returns (int256) {
        require(0 < x); //你也可以通过将输入更改为uint类型并删除require语句来修复合约。
        return 42;
    }
}