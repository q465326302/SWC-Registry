/*
 * @来源1: http://blockchain.unica.it/projects/ethereum-survey/attacks.html#simpledao
 * @作者: Atzei N., Bartoletti M., Cimoli T
 * 由Bernhard Mueller, Josselin Feist修改
 */
pragma solidity 0.4.24;

contract SimpleDAO {
  mapping (address => uint) public credit;

  function donate(address to) payable public{
    credit[to] += msg.value;
  }

  function withdraw(uint amount) public {
    if (credit[msg.sender]>= amount) {
      credit[msg.sender]-=amount;
      require(msg.sender.call.value(amount)());
    }
  }  

  function queryCredit(address to) view public returns (uint){
    return credit[to];
  }
}