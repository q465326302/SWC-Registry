pragma solidity ^0.4.24;

contract proxy{
  address owner;

  function proxyCall(address _to, bytes _data) external {
    require( !_to.delegatecall(_data));
  }
  function withdraw() external{
    require(msg.sender == owner);
    msg.sender.transfer(address(this).balance);
  }
} 

/*
使用proxyCall无法更改所有者地址，原因如下：
1) 如果委托调用发生回滚，所有者不会发生变化。
2) 如果委托调用没有回滚，那么proxyCall将会回滚，阻止所有者的变更。

这种误报可能看起来是一个非常特殊的情况，然而由于可以将数据还原到proxy，这种模式对于代理架构是有用的。
*/