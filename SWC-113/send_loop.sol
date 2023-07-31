/*
 * @source: https://consensys.github.io/smart-contract-best-practices/known_attacks/#dos-with-unexpected-revert
 * @author: ConsenSys Diligence
 * Modified by Bernhard Mueller
 */

pragma solidity 0.4.24;

contract Refunder {

address[] private refundAddresses;
mapping (address => uint) public refunds;

    constructor() {
        refundAddresses.push(0x79B483371E87d664cd39491b5F06250165e4b184);
        refundAddresses.push(0x79B483371E87d664cd39491b5F06250165e4b185);
    }

    // bad
    function refundAll() public {
        for(uint x; x < refundAddresses.length; x++) { // 基于参与地址数量的任意长度迭代
            require(refundAddresses[x].send(refunds[refundAddresses[x]])); // 更糟糕的是，现在一次发送失败将会阻塞所有资金
        }
    }

}