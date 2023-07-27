/*
 * @source: https://capturetheether.com/challenges/lotteries/guess-the-random-number/
 * @author: Steve Marx
 */

pragma solidity ^0.4.25;

contract GuessTheRandomNumberChallenge {
    uint8 answer;
    uint8 commitedGuess;
    uint commitBlock;
    address guesser;

    function GuessTheRandomNumberChallenge() public payable {
        require(msg.value == 1 ether);
    }

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    //猜测你的区块哈希之后20个区块的模数。
    function guess(uint8 _guess) public payable {
        require(msg.value == 1 ether);
        commitedGuess = _guess;
        commitBlock = block.number;
        guesser = msg.sender;
    }
    function recover() public {
      //在猜测的区块之后、commitBlock+20的区块哈希不可恢复之前，必须调用此函数。
      require(block.number > commitBlock + 20 && commitBlock+20 > block.number - 256);
      require(guesser == msg.sender);

      if(uint(blockhash(commitBlock+20)) == commitedGuess){
        msg.sender.transfer(2 ether);
      }
    }
}