/******************************************************************************
file name   : contract.sol
author      : Kevin Zhang
vendor      : 北京粒子时代科技有限公司(http://liziblockchain.com)
location    : https://github.com/liziblockchain/bctprimary/
description : 工业和信息化部-区块链基础理论课程（初级）培训教程配套源码
******************************************************************************/
// SPDX-License-Identifier: GPLv3

pragma solidity ^0.6.0;

// 基本可见性定义
contract C {
   //private state variable
   uint private data;

   //public state variable
   uint public info;

   //constructor
   constructor() public {
      info = 10;
   }
   //private function
   function increment(uint a) private pure returns(uint) { return a + 1; }

   //public function
   function updateData(uint a) public { data = a; }
   function getData() public view virtual returns(uint) { return data; }
   function compute(uint a, uint b) internal pure returns (uint) { return a + b; }
}

//External Contract
contract D {
   function readData() public returns(uint) {
      C c = new C();
      c.updateData(7);
      return c.getData();
   }
}

//Derived Contract
contract E is C {
   uint private result;
   C private c;

   constructor() public {
      c = new C();
   }
   function getComputedResult() public {
      result = compute(3, 5);
   }
   function getResult() public view returns(uint) { return result; }
   function getData() public view override returns(uint) { return c.info(); }
}


// 构造函数继承
contract Base {
   uint data;
   constructor(uint _data) public {
      data = _data;
   }
}
contract Derived is Base (5) {
   constructor() public {}
}


// 抽象合约
abstract contract Calculator {
   function getResult() public view virtual returns(uint);
}

contract Test is Calculator {
   function getResult() public view override returns(uint) {
      uint a = 1;
      uint b = 2;
      uint result = a + b;
      return result;
   }
}

// 接口
interface CalculatorInterface {
   function getResult() external view returns(uint);
}

contract TestInterface is CalculatorInterface {
   constructor() public {}
   function getResult() external view override returns(uint){
      uint a = 1;
      uint b = 2;
      uint result = a + b;
      return result;
   }
}

// 库
library Search {
   function indexOf(uint[] storage self, uint value) public view returns (uint) {
      for (uint i = 0; i < self.length; i++) {
          if (self[i] == value) return i;
      }
      return uint(-1);
   }
}

contract TestSearch {
   uint[] data;
   constructor() public {
      data.push(1);
      data.push(2);
      data.push(3);
      data.push(4);
      data.push(5);
   }
   function isValuePresent() external view returns(uint){
      uint value = 4;

      // 使用库函数搜索数组中是否存在值
      uint index = Search.indexOf(data, value);
      return index;
   }
}


// Using For
library Search2 {
   function indexOf(uint[] storage self, uint value) public view returns (uint) {
      for (uint i = 0; i < self.length; i++)if (self[i] == value) return i;
      return uint(-1);
   }
}
contract TestSearch2 {
   using Search for uint[];
   uint[] data;
   constructor() public {
      data.push(1);
      data.push(2);
      data.push(3);
      data.push(4);
      data.push(5);
   }
   function isValuePresent() external view returns(uint){
      uint value = 4;

      // data 表示库
      uint index = data.indexOf(value);
      return index;
   }
}


// 事件(Event)
contract Counter {
    uint256 public count = 0;

    event Increment(address who);   // 声明事件

    function increment() public {
        emit Increment(msg.sender); // 触发事件
        count += 1;
    }
}



// 索引(indexed)参数
contract Multicounter {
    mapping (uint256 => uint256) public counts;

    event Increment(uint256 indexed which, address who);

    function increment(uint256 which) public {
        emit Increment(which, msg.sender);
        counts[which] += 1;
    }
}
