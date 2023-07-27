pragma solidity ^0.4.25;

// 基于部署在0xcac337492149bDB66b088bf5914beDfBf78cCC18的TheRun合约。
contract RandomNumberGenerator {
  uint256 private salt =  block.timestamp;

  function random(uint max) view private returns (uint256 result) {
    // 获取最佳的随机种子
    uint256 x = salt * 100 / max;
    uint256 y = salt * block.number / (salt % 5);
    uint256 seed = block.number / 3 + (salt % 300) + y;
    uint256 h = uint256(blockhash(seed));
    // 在1和最大值之间生成随机数
    return uint256((h / x)) % max + 1;
  }
}