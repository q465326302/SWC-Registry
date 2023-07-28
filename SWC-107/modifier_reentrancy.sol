pragma solidity ^0.5.0;

contract ModifierEntrancy {

  mapping (address => uint) public tokenBalance;
  string constant name = "Nu Token";
  Bank bank;

  constructor() public{
      bank = new Bank();
  }

  //如果一个合约的余额为零并且支持代币，给它一些代币。
  function airDrop() hasNoBalance supportsToken  public{
    tokenBalance[msg.sender] += 20;
  }

  //检查合同是否按我们所希望的方式进行响应。
  modifier supportsToken() {
    require(keccak256(abi.encodePacked("Nu Token")) == bank.supportsToken());
    _;
  }

  //检查调用者是否有零余额
  modifier hasNoBalance {
      require(tokenBalance[msg.sender] == 0);
      _;
  }
}

contract Bank{

    function supportsToken() external returns(bytes32) {
        return keccak256(abi.encodePacked("Nu Token"));
    }

}