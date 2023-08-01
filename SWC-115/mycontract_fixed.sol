/*
 * @来源: https://consensys.github.io/smart-contract-best-practices/recommendations/#avoid-using-txorigin
 * @作者: Consensys Diligence
 * 由Gerhard Wagner修改
 */

pragma solidity 0.4.25;

contract MyContract {

    address owner;

    function MyContract() public {
        owner = msg.sender;
    }

    function sendTo(address receiver, uint amount) public {
      require(msg.sender == owner);
      receiver.transfer(amount);
    }

}