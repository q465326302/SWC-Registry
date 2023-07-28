/* 
 * @source: TrailofBits在TruffleCon 2018的研讨会
 * @作者：Josselin Feist（由Bernhard Mueller适应SWC）
 * 三个消息调用的断言违规：
 * - airdrop()
 * - backdoor()
 * - test_invariants()
 */
pragma solidity ^0.4.22;

contract Token{

    mapping(address => uint) public balances;
    function airdrop() public{
        balances[msg.sender] = 1000;
    }

    function consume() public{
        require(balances[msg.sender]>0);
        balances[msg.sender] -= 1;
    }

    function backdoor() public{
        balances[msg.sender] += 1;
    }

   function test_invariants() {
      assert(balances[msg.sender] <= 1000);
  }
}