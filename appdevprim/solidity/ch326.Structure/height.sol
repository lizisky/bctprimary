/******************************************************************************
File name   : height.sol
Author      : Kevin Zhang
Vendor      : 粒子区块链(http://liziblockchain.com)
Location    : https://github.com/liziblockchain/bctprimary/
Description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
******************************************************************************/
// SPDX-License-Identifier: GPLv3

pragma solidity ^0.6.0;

contract Height {

     uint32 height;

    function setHeight(uint32 ht) public {
        height = ht;
    }
    
    function getHeight() public view returns (uint32) {
        return height;
    }
}
