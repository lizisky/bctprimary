/******************************************************************************
File name   : dataType.sol
Author      : Kevin Zhang
Vendor      : 粒子区块链(http://liziblockchain.com)
Location    : https://github.com/liziblockchain/bctprimary/
Description : 工业和信息化部-区块链基础理论课程（初级）培训教程配套源码
******************************************************************************/
// SPDX-License-Identifier: GPLv3

pragma solidity ^0.6.0;

// bool 类型
contract testBool {
    bool isInit;
    bool v2;

    constructor() public {
        isInit = true;
    }

    function set(bool vb) public {
        v2 = vb;
    }

    function test() public {
        // isInit = !isInit;
        bool v1 = isInit && true;
        bool v3 = (isInit == true);
        bool v4 = (isInit != true);

        isInit = v1 || v3 || v4;
        // v2 = v2 || ;
    }

    function get() public view returns (bool) {
        return v2;
    }
}

// 整数类型
contract TestInt {
    int8 v1;
    int16 v2;
    int24 v3;
    int32 v4;
    // int40, int48, int56 .....
    int256 v256;

    function set(int32 num) public {
        v4 = num;
    }

    function test() public {
        v1 = 1;
        v2 = v1 << 2;
        v3 = -v1;
        v4 = v2 << 1;

        v4 = v4**4;
    }

    function get() public view returns (int32) {
        return v4;
    }
}

// 地址类型
contract TestAddress {

    function test() public {
        address payable x = 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;
        address y = 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;
        address myAddress = msg.sender;
        if (x.balance < 10 && myAddress.balance >= 10) {
            x.transfer(10);
        }

        address v2 = x;
        address payable v1 = payable(y);
        // address payable v2 = y;
    }
}


// 合约类型
contract Dcon {
    uint x;
    function test(uint a) public payable {
        x = a;
    }
}

contract DconTest {
    Dcon dcon;
    address x;
    function test() public payable {
        dcon = new Dcon();
        x = address(dcon);
    }
}

// 定长字节数组
contract TestFixBytes{
    // 一个字节 八位 固定大小数组内容和长度都不可修改
    bytes11 a = "6c111122ab9";//
    bytes1 b = 0x69;//105
    function test1() public view returns(bool){
         return a <= b;
     }
    function test2() public view returns(bool){
         return a < b;
     }
    function test3() public view returns(bool){
         return a == b;
     }
    function test4() public view returns(bool){
         return a >= b;
     }
    function test5() public view returns(bool){
         return a > b;
     }
    // 索引访问
    function indeOf() public view returns(byte){
        return a[0];
    }
    // 获取数组长度
    function getLengthOfBytes() public view returns(uint){
        return a.length;
    }
}

// 枚举类型
contract testEnum {
    enum ActionChoices { GoLeft, GoRight, GoStraight, SitStill }
    ActionChoices choice;
    ActionChoices constant defaultChoice = ActionChoices.GoStraight;

    function setGoStraight() public {
        choice = ActionChoices.GoStraight;
    }

    // 由于枚举类型不属于 |ABI| 的一部分，因此对于所有来自 Solidity 外部的调用，
    // "getChoice" 的签名会自动被改成 "getChoice() returns (uint8)"。
    // 整数类型的大小已经足够存储所有枚举类型的值，随着值的个数增加，
    // 可以逐渐使用 `uint16` 或更大的整数类型。
    function getChoice() public view returns (ActionChoices) {
        return choice;
    }

    function getDefaultChoice() public pure returns (uint) {
        return uint(defaultChoice);
    }
}
