/******************************************************************************
file name   : funcType.sol
author      : Kevin Zhang
vendor      : 北京粒子时代科技有限公司(http://lizitime.com)
location    : https://github.com/lizitime/bctprimary/
description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
******************************************************************************/
// SPDX-License-Identifier: GPLv3

pragma solidity ^0.6.0;

// function sample
contract BasicSample {
   function getResult() public view returns(uint){
      uint a = 1; // 局部变量
      uint b = 2;
      uint result = a + b;
      return result;
   }
}

// 函数多返回值
contract TestMultiResult {
   function getResult() public view returns(uint product, uint sum){
      uint a = 1; // 局部变量
      uint b = 2;
      product = a * b; // 使用返回参数返回值
      sum = a + b; // 使用返回参数返回值

      // 也可以使用return返回多个值
      // return(a*b, a+b);
   }
}

// 修饰符
contract Owner {
   address owner;

   // 定义修饰符 onlyOwner 不带参数
   modifier onlyOwner {
      require(msg.sender == owner);
      _;
   }

   // 定义修饰符 costs 带参数
   modifier costs(uint price) {
      if (msg.value >= price) {
         _;
      }
   }
}

contract Register is Owner {
   uint price;

   // 使用修饰符 onlyOwner
   function changePrice(uint _price) public payable costs(_price) {
      price = _price;
   }

   function getPrice() public view returns (uint) {
       return price;
   }
}


// View(视图)函数
contract TestView {
   uint sum;
   function getResult() public view returns(uint product, uint _sum){
      uint a = 1; // 局部变量
      uint b = 2;
      product = a * b;
      _sum = a + b + sum;
   }
}


// Pure(纯)函数
contract TestPure {
   function getResult() public pure returns(uint sum) {
      uint a = 1; 
      uint b = 2;
      sum = a + b; 
   }
}

// fallback(回退)函数
contract Test {
   uint public x ;
   fallback() external { x = 1; }    
}

contract Sink {
   fallback() external payable { }
}

contract Caller {

   function callTest(Test test) public returns (bool) {
      (bool success,) = address(test).call(abi.encodeWithSignature("nonExistingFunction()"));
      require(success);
      // test.x 是 1

      address payable testPayable = address(uint160(address(test)));

      // 发送以太测试合同,
      // 转账将失败，也就是说，这里返回false。
      return (testPayable.send(2 ether));
   }

   function callSink(Sink sink) public returns (bool) {
      address payable sinkPayable = address(sink);
      return (sinkPayable.send(2 ether));
   }
}


// 函数重载
contract TestOverride {
   function getSum(uint a, uint b) public pure returns(uint){      
      return a + b;
   }
   function getSum(uint a, uint b, uint c) public pure returns(uint){      
      return a + b + c;
   }
   function callSumWithTwoArguments() public pure returns(uint){
      return getSum(1,2);
   }
   function callSumWithThreeArguments() public pure returns(uint){
      return getSum(1,2,3);
   }
}

// 数学函数
contract TestMath {   
   function callAddMod() public pure returns(uint){
      return addmod(4, 5, 3);
   }
   function callMulMod() public pure returns(uint){
      return mulmod(4, 5, 3);
   }
}

// 加密函数
contract TestCrypto {   
   function callKeccak256() public pure returns(bytes32 result){
      return keccak256("ABC");
   }  
}
