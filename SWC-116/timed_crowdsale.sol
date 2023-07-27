pragma solidity ^0.5.0;

contract TimedCrowdsale {

  event Finished();
  event notFinished();

  // 销售应该在2019年1月1日准确结束。
  function isSaleFinished() private returns (bool) {
    return block.timestamp >= 1546300800;
  }

  function run() public {
    if (isSaleFinished()) {
        emit Finished();
    } else {
        emit notFinished();
    }
  }

}
