/******************************************************************************
File name   : client.go
Author      : Kevin Zhang
Vendor      : 粒子区块链(http://liziblockchain.com)
Location    : https://github.com/liziblockchain/bctprimary/
Description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
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
