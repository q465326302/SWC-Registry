/*
 * @作者: Steve Marx
 * 由Kaden Zipfel修改
 */

pragma solidity ^0.5.0;

import "./ECDSA.sol";

contract AccessControl {
    using ECDSA for bytes32;
    mapping(address => bool) isAdmin;
    mapping(address => bool) isRegularUser;
    // 添加一个单一用户，可以是管理员或普通用户。
    function addUser(
        address user,
        bool admin,
        bytes calldata signature
    )
        external
    {
        if (!isAdmin[msg.sender]) {
            // 允许使用管理员的签名转发calls。
            bytes32 hash = keccak256(abi.encodePacked(user));
            address signer = hash.toEthSignedMessageHash().recover(signature);
            require(isAdmin[signer], "Only admins can add users.");
        }
        if (admin) {
            isAdmin[user] = true;
        } else {
            isRegularUser[user] = true;
        }
    }
}