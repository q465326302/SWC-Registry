/*
 * @source: https://github.com/sigp/solidity-security-blog#visibility
 * @author: SigmaPrime
 * Modified by Gerhard Wagner
 */

pragma solidity ^0.4.24;

contract HashForEther {

    function withdrawWinnings() public {
        // 如果地址的最后8个十六进制字符为0，则为赢家。
        require(uint32(msg.sender) == 0);
        _sendWinnings();
     }

     function _sendWinnings() internal{
         msg.sender.transfer(this.balance);
     }
}