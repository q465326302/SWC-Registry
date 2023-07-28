/*
 * @source: ChainSecurity
 * @author: Anton Permenev
 * 断言违规，有两个消息调用:
 * - set(66)
 * - check(0x4100000000000000000000000000000000000000000000000000000000000000)
 */
pragma solidity ^0.4.22;

contract ShaOfShaCollission{

    mapping(bytes32=>uint) m;

    function set(uint x){
        m[keccak256(abi.encodePacked("A", x))] = 1;
    }
    function check(uint x){
        assert(m[keccak256(abi.encodePacked(x, "B"))] == 0);
    }

}