pragma solidity 0.4.25;

//我们通过消除覆盖首选硬上限的声明来解决这个问题。

contract Tokensale {
    uint public hardcap = 10000 ether;

    function Tokensale() {}

    function fetchCap() public constant returns(uint) {
        return hardcap;
    }
}

contract Presale is Tokensale {
    //uint hardcap = 1000以太;
    // 如果需要使用两个hardcap变量，我们需要将其中一个重命名以解决此问题。
    function Presale() Tokensale() {
        hardcap = 1000 ether; //我们将Tokensale的硬顶从构造函数设置为1000，而不是10000。
    }
}