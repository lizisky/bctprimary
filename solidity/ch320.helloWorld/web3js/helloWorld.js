/******************************************************************************
file name   : helloWorld.js
author      : Kevin Zhang
vendor      : 北京粒子时代科技有限公司(http://lizitime.com)
location    : https://github.com/lizitime/bctprimary/
description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
******************************************************************************/

"use strict";

const WEB3 = require('web3');

var web3 = new WEB3('ws://localhost:8546');
// console.log(web3);

web3.eth.getAccounts().then(console.log);

web3.eth.getBlock(0).then(console.log);
