/*
 * @来源: https://consensys.github.io/smart-contract-best-practices/known_attacks/#insufficient-gas-griefing
 * @作者: ConsenSys Diligence
 * 由Kaden Zipfel修改
 */

pragma solidity ^0.5.0;

contract Relayer {
    uint transactionId;

    struct Tx {
        bytes data;
        bool executed;
    }

    mapping (uint => Tx) transactions;

    function relay(Target target, bytes memory _data) public returns(bool) {
        // 重放保护；不要重复调用相同的交易
        require(transactions[transactionId].executed == false, 'same transaction twice');
        transactions[transactionId].data = _data;
        transactions[transactionId].executed = true;
        transactionId += 1;

        (bool success, ) = address(target).call(abi.encodeWithSignature("execute(bytes)", _data));
        return success;
    }
}

// 中继器调用的合约
contract Target {
    function execute(bytes memory _data) public {
        // 执行合约代码
    }
}