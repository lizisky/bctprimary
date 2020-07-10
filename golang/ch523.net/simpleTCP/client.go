/******************************************************************************
file name   : client.go
author      : Kevin Zhang
vendor      : 北京粒子时代科技有限公司(http://lizitime.com)
location    : https://github.com/liziblockchain/bctprimary/
description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
******************************************************************************/

package main

import (
	"fmt"
	"net"
)

func main() {
	//打开连接:
	conn, err := net.Dial("tcp", "localhost:54321")
	if err != nil {
		//由于目标计算机积极拒绝而无法创建连接
		fmt.Println("Error dialing", err.Error())
		return // 终止程序
	}

	msg := "this is 粒子区块链"
	_, err = conn.Write([]byte(msg))

}
