/******************************************************************************
file name   : server.go
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
	fmt.Println("Starting the server ...")
	// 创建 listener
	listener, err := net.Listen("tcp", "localhost:54321")
	if err != nil {
		fmt.Println("Error listening", err.Error())
		return //终止程序
	}
	// 监听并接受来自客户端的连接
	// for {
	conn, err := listener.Accept()
	if err != nil {
		fmt.Println("Error accepting", err.Error())
		return // 终止程序
	}
	doServerStuff(conn)

	// 监听并接受来自客户端的连接
	// for {
	// 	conn, err := listener.Accept()
	// 	if err != nil {
	// 		fmt.Println("Error accepting", err.Error())
	// 		return // 终止程序
	// 	}
	// 	go doServerStuff(conn)
	// }

}

func doServerStuff(conn net.Conn) {
	for {
		buf := make([]byte, 512)
		len, err := conn.Read(buf)
		if err != nil {
			fmt.Println("Error reading", err.Error())
			return //终止程序
		}
		fmt.Printf("Received data: %v\n", string(buf[:len]))
	}
}
