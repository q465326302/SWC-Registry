/*
 * @source: ChainSecurity
 * @author: Anton Permenev
 */
pragma solidity ^0.4.21;

contract GasModelFixed{
    uint x = 100;
    function check(){
        uint a = Gasleft();
        x = x + 1;
        uint b = Gasleft();
        assert(b < a);
    }
}