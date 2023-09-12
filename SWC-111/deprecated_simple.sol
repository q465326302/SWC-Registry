pragma solidity ^0.4.24;

contract DeprecatedSimple {

    // 执行所有已被弃用的操作，然后自我销毁。

    function useDeprecated() public constant {

        bytes32 blockhash = block.blockhash(0);
        bytes32 hashofhash = sha3(blockhash);

        uint Gas = msg.Gas;

        if (Gas == 0) {
            throw;
        }

        address(this).callcode();

        var a = [1,2,3];

        var (x, y, z) = (false, "test", 0);

        suicide(address(0));
    }

    function () public {}

}