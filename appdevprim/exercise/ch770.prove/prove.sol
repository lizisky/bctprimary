/******************************************************************************
file name   : prove.sol
author      : Kevin Zhang
vendor      : 北京粒子时代科技有限公司(http://liziblockchain.com)
location    : https://github.com/liziblockchain/bctprimary/
description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
******************************************************************************/
// SPDX-License-Identifier: GPLv3

pragma solidity >=0.6.0 <0.7.0;

contract DataModel {
    struct Abstract {
        uint timestamp;
        address sender;
        uint version;
        bytes32 hash;
        byte[512] extend;
    }

    mapping(bytes32 => Abstract) abstractData;
    mapping(address => bool) public allowedMap;
    address[] public allowedArray;

    constructor() public {
        allowedMap[msg.sender] = true;
        allowedArray.push(msg.sender);
    }

    modifier allow() {
        assert(allowedMap[msg.sender] == true);
        _;
    }

    function allowAccess(address _address) allow public {
        allowedMap[_address] = true;
        allowedArray.push(_address);
    }

    function denyAccess(address _address) allow public {
        allowedMap[_address] = false;
    }

    function getData(bytes32 _key) public view returns(uint, address, uint, bytes32, byte[512] memory) {
        return (
            abstractData[_key].timestamp,
            abstractData[_key].sender,
            abstractData[_key].version,
            abstractData[_key].hash,
            abstractData[_key].extend
        );
    }

    function setData(bytes32 _key, uint timestamp, address sender, uint version, bytes32 hash) allow public {
        abstractData[_key].timestamp = timestamp;
        abstractData[_key].sender = sender;
        abstractData[_key].version = version;
        abstractData[_key].hash = hash;
    }

    function setExtend(bytes32 _key, byte[512] memory extend) allow public {
        if (abstractData[_key].version > 0) {
            for (uint256 i; i < 512; i++) {
                abstractData[_key].extend[i] = extend[i];
            }
        }
    }
}
