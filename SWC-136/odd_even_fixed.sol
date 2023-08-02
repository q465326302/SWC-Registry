/*
 * @来源: https://github.com/yahgwai/rps
 * @作者: Chris Buckland
 * 由Kaden Zipfel修改
 */

pragma solidity ^0.5.0;

contract OddEven {
    enum Stage {
        FirstCommit,
        SecondCommit,
        FirstReveal,
        SecondReveal,
        Distribution
    }

    struct Player {
        address addr;
        bytes32 commitment;
        uint number;
    }

    Player[2] private players;
    Stage public stage = Stage.FirstCommit;

    function play(bytes32 commitment) public payable {
        // 仅在提交阶段运行
        uint playerIndex;
        if(stage == Stage.FirstCommit) playerIndex = 0;
        else if(stage == Stage.SecondCommit) playerIndex = 1;
        else revert("only two players allowed");

        // 需要适当的存款金额
        // 1 ETH as a bet + 1 ETH as a bond
        require(msg.value == 2 ether, 'msg.value must be 2 eth');

        // 存储承诺
        players[playerIndex] = Player(msg.sender, commitment, 0);

        // 进入下一个阶段
        if(stage == Stage.FirstCommit) stage = Stage.SecondCommit;
        else stage = Stage.FirstReveal;
    }

    function reveal(uint number, bytes32 blindingFactor) public {
        // 仅在揭示阶段运行
        require(stage == Stage.FirstReveal || stage == Stage.SecondReveal, "wrong stage");

        // 找到玩家索引
        uint playerIndex;
        if(players[0].addr == msg.sender) playerIndex = 0;
        else if(players[1].addr == msg.sender) playerIndex = 1;
        else revert("unknown player");

        // 检查哈希值以证明玩家的诚实性
        require(keccak256(abi.encodePacked(msg.sender, number, blindingFactor)) == players[playerIndex].commitment, "invalid hash");

        // 如果正确，请更新玩家数量
        players[playerIndex].number = number;

        // 进入下一个阶段
        if(stage == Stage.FirstReveal) stage = Stage.SecondReveal;
        else stage = Stage.Distribution;
    }

    function distribute() public {
        // 只在分发阶段运行
        require(stage == Stage.Distribution, "wrong stage");

        // 找到获胜者
        uint n = players[0].number + players[1].number;

        // 支付获胜者的奖金和债券
        players[n%2].addr.call.value(3 ether)("");

        // 回报失败者的债券
        players[(n+1)%2].addr.call.value(1 ether)("");

        // 重置状态
        delete players;
        stage = Stage.FirstCommit;
    }
}