/*
 * @来源：ChainSecurity
 * @作者：Anton Permenev
 * 断言违规，包含2个消息调用：
 * - B.set_x(X): X != 10
 * - ContructorCreateModifiable.check()
 */

pragma solidity ^0.4.22;

contract ContructorCreateModifiable{
    B b = new B(10);

    function check(){
        assert(b.foo() == 10);
    }

}

contract B{

    uint x_;
    constructor(uint x){
        x_ = x;
    }

    function foo() returns(uint){
        return x_;
    }

    function set_x(uint x){
        x_ = x;
    }
}