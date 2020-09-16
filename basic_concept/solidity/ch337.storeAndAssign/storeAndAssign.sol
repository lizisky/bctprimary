/******************************************************************************
File name   : referenceType.sol
Author      : Kevin Zhang
Vendor      : 粒子区块链(http://liziblockchain.com)
Location    : https://github.com/liziblockchain/bctprimary/
Description : 工业和信息化部-区块链基础理论课程（初级）培训教程配套源码
******************************************************************************/
// SPDX-License-Identifier: GPLv3

pragma solidity ^0.6.0;

// function sample
contract DataLocationStateVariable {
   // storage
   uint stateVariable;
   uint[] stateArray;
}

// 不能显式地标记状态变量的位置。
contract DataLocationWrong {
//   uint storage stateVariable; // 错误
//   uint[] memory stateArray; // 错误
}

// 函数参数
contract DataLocationFuncParameter {
   // storage
   uint stateVariable;
   uint[] stateArray;

   // 函数参数包括返回参数都存储在内存中
   function calculate(uint num1, uint num2) public pure returns (uint result) {
      return num1 + num2;
   }
}

// 局部变量
contract DataLocationsLocalVar {

  // 状态变量----存储在storage中
  bool flag;
  uint number;
  address account;

  function doSomething() public pure {
    /* 函数内部都是局部变量  */
    // 值类型
    // 所以它们被存储在内存中
    bool flag2;
    uint number2;
    address account2;

    // 引用类型，需要显示指定数据位置，此处指定为内存
    uint[] memory localArray;
  }
}

// 存储变量赋值给存储变量
contract AsignStateVar {

  uint public stateVar1 = 10;
  uint stateVar2 = 20;

  function doSomething() public returns (uint) {

   stateVar1 = stateVar2;
   stateVar2 = 30;

   return stateVar1; //returns 20
  }
}


// 内存变量复制到存储变量
contract AsignMemoryStorage {

    uint stateVar = 10; //storage

    function doSomething() public returns(uint) {

        uint localVar = 20; //memory
        stateVar = localVar;
        localVar = 40;

        return stateVar; //returns 20
    }
}

// 存储变量复制到内存变量
contract AsignStorgeMemory {

    uint stateVar = 10; //storage

    function doSomething() public returns(uint) {

        uint localVar = 20; //memory
        localVar = stateVar;
        stateVar = 40;

        return localVar; //returns 10
    }
}

// 内存变量复制到内存变量
contract AsignMemory2Memory {

    function doSomething()
        public pure returns(uint[] memory, uint[] memory) {

        uint[] memory localMemoryArray1 = new uint[](3);
        localMemoryArray1[0] = 4;
        localMemoryArray1[1] = 5;
        localMemoryArray1[2] = 6;

        uint[] memory localMemoryArray2 = localMemoryArray1;
        localMemoryArray1[0] = 10;

        return (localMemoryArray1, localMemoryArray2);
       //returns 10,4,6 | 10,4,6
    }
}
