/******************************************************************************
file name   : controlFlow.sol
author      : Kevin Zhang
vendor      : 北京粒子时代科技有限公司(http://liziblockchain.com)
location    : https://github.com/liziblockchain/bctprimary/
description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
******************************************************************************/
// SPDX-License-Identifier: GPLv3

pragma solidity ^0.6.0;

// if .. else if ... else
contract TestIfElse {

   uint storedData; // State variable

   constructor() public {
      storedData = 10;   
   }

   function getResult() public pure returns(uint) {
      uint a = 1; 
      uint b = 2;
      uint c = 3;
      uint result;

      if( a > b && a > c) {   // if else if 语句
         result = a;
      } else if( b > a && b > c ){
         result = b;
      } else {
         result = c;
      }       
      return (result); 
   }
}



// while 
contract TestWhile {

   function getResult() public pure returns(uint) {
      uint i = 1; 
      uint result;
      
      while (i < 10) {
          result += i;
          i++;
      }

      return (result); 
   }
}

// do...while
contract TestDoWhile {

   function getResult() public pure returns(uint) {
      uint i = 1; 
      uint result;
      
      do {
          result += i;
          i++;
      } while (i < 10);

      return (result); 
   }
}

// for
contract TestFor {
   function getResult() public pure returns(uint) {
      uint i = 1;
      uint result = 0;
      for (i = 0; i < 10; i++) {
          result += i;
      }
      return (result);
    }
}


// break
contract TestBreak {
   function getResult() public pure returns(uint) {
      uint i = 1;
      uint result = 0;
      for (i = 0; i < 10; i++) {
          if (i > 5) break;
          result += i;
      }
      return (result);
    }
}

// continue
contract TestContinue {
   function getResult() public pure returns(uint) {
      uint i = 1;
      uint result = 0;
      for (i = 0; i < 10; i++) {
          if (i == 5) continue;
          result += i;
      }
      return (result);
    }
}
