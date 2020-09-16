/******************************************************************************
File name   : helloWorld.js
Author      : Kevin Zhang
Vendor      : 粒子区块链(http://liziblockchain.com)
Location    : https://github.com/liziblockchain/bctprimary/
Description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
******************************************************************************/

"use strict";

const WEB3 = require('web3');

var web3 = new WEB3('ws://localhost:8546');
// console.log(web3);

web3.eth.getAccounts().then(console.log);

web3.eth.getBlock(0).then(console.log);
