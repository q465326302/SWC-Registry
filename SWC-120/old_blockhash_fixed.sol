pragma solidity ^0.4.24;

//根据https://capturetheether.com/challenges/lotteries/predict-the-block-hash/上的Capture the Ether挑战

//请注意，尽管你似乎有1/2^256的机会猜对哈希值，实际上，对于超过256个区块之前的区块号，blockhash函数会返回零，所以你可以猜测零并等待。
contract PredictTheBlockHashChallenge {

    struct guess{
      uint block;
      bytes32 guess;
    }

    mapping(address => guess) guesses;

    constructor() public payable {
        require(msg.value == 1 ether);
    }

    function lockInGuess(bytes32 hash) public payable {
        require(guesses[msg.sender].block == 0);
        require(msg.value == 1 ether);

        guesses[msg.sender].guess = hash;
        guesses[msg.sender].block  = block.number + 1;
    }

    function settle() public {
        require(block.number > guesses[msg.sender].block +10);
        //请注意，这个解决方案可以防止 blockhash(guesses[msg.sender].block) 为零的攻击。
        //此外，我们还添加了十个区块的冷却期，以防止矿工利用对下一个区块哈希的预知。
        if(guesses[msg.sender].block - block.number < 256){
          bytes32 answer = blockhash(guesses[msg.sender].block);

          guesses[msg.sender].block = 0;
          if (guesses[msg.sender].guess == answer) {
              msg.sender.transfer(2 ether);
          }
        }
        else{
          revert("Sorry your lottery ticket has expired");
        }
    }
}