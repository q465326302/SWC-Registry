/*
 * @来源：https://forum.zeppelin.solutions/t/using-automatic-analysis-tools-with-makerdao-contracts/1021/3
 * 作者：Dan Guido / Trail of Bits
 * 经Bernhard Mueller稍作修改

* 可能在3个交易中发生断言违规：
*
* etch(addr)
* lookup(slate, addr)
* checkAnInvariant()

* 其中 slate == Keccak(addr)
*
* 理想情况下，工具应该输出正确的交易跟踪。
*/

pragma solidity ^0.5.0;

contract ReturnMemory {
    mapping(bytes32=>address) public slates;
    bool everMatched = false;

    function etch(address yay) public returns (bytes32 slate) {
        bytes32 hash = keccak256(abi.encodePacked(yay));
        slates[hash] = yay;
        return hash;
    }

    function lookup(bytes32 slate, address nay) public {
       if (nay != address(0x0)) {
         everMatched = slates[slate] == nay;
       }
    }

    function checkAnInvariant() public returns (bool) {
        assert(!everMatched);
    }
}