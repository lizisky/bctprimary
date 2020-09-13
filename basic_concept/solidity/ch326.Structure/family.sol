/******************************************************************************
file name   : family.sol
author      : Kevin Zhang
vendor      : 北京粒子时代科技有限公司(http://liziblockchain.com)
location    : https://github.com/liziblockchain/bctprimary/
description : 工业和信息化部-区块链基础理论课程（初级）培训教程配套源码
******************************************************************************/
// SPDX-License-Identifier: GPLv3

pragma solidity ^0.6.0;

contract Family {

    struct Person {
        bytes32 name;
        uint32 age;
    }
    Person   leader;

    function setAge(uint32 ag) public {
        leader.age = ag;
    }

    function getAge() public view returns (uint32) {
        return leader.age;
    }
}
