/******************************************************************************
file name   : height.sol
author      : Kevin Zhang
vendor      : 北京粒子时代科技有限公司(http://lizitime.com)
location    : https://github.com/liziblockchain/bctprimary/
description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
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
