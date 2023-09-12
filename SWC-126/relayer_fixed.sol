/*
 * @来源: https://consensys.github.io/smart-contract-best-practices/known_attacks/#insufficient-Gas-griefing
 * @作者: ConsenSys Diligence
 *  由Kaden Zipfel修改
 */

pragma solidity ^0.5.0;

contract Relayer {
    uint transactionId;

    struct Tx {
        bytes data;
        bool executed;
    }

    mapping (uint => Tx) transactions;

    function relay(Target target, bytes memory _data, uint _GasLimit) public {
        // 重放保护；不要重复调用相同的交易
        require(transactions[transactionId].executed == false, 'same transaction twice');
        transactions[transactionId].data = _data;
        transactions[transactionId].executed = true;
        transactionId += 1;

        address(target).call(abi.encodeWithSignature("execute(bytes)", _data, _GasLimit));
    }
}

// 合约由中继者调用
contract Target {
    function execute(bytes memory _data, uint _GasLimit) public {
        require(Gasleft() >= _GasLimit, 'not enough Gas');
        // 执行合约代码
    }
}