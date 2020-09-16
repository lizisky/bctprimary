/******************************************************************************
File name   : family.sol
Author      : Kevin Zhang
Vendor      : 粒子区块链(http://liziblockchain.com)
Location    : https://github.com/liziblockchain/bctprimary/
Description : 工业和信息化部-区块链基础理论课程（初级）培训教程配套源码
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
