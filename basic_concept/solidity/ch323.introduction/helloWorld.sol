/******************************************************************************
file name   : helloWorld.sol
author      : Kevin Zhang
vendor      : 北京粒子时代科技有限公司(http://liziblockchain.com)
location    : https://github.com/liziblockchain/bctprimary/
description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
******************************************************************************/
// SPDX-License-Identifier: GPLv3

pragma solidity ^0.6.0;

contract HelloWorld {
    uint256 number;

    function set(uint256 num) public {
        number = num;
    }

    function get() public view returns (uint256){
        return number;    
    }
}
