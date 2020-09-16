/******************************************************************************
File name   : socketReadData.go.go
Author      : Kevin Zhang
Vendor      : 粒子区块链(http://liziblockchain.com)
Location    : https://github.com/liziblockchain/bctprimary/
Description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
******************************************************************************/

package main

import (
	"fmt"
	"io"
	"net"
)

func main() {
	fmt.Println("Hello, 世界!")
	trySocket()
}

//-----------------------------------------------------------------------------
// socket
func trySocket() {
	var (
		host   = "www.apache.org"
		port   = "80"
		remote = host + ":" + port
		msg    = "GET / \n"
		data   = make([]uint8, 4096)
		read   = true
		count  = 0
	)
	// 创建一个socket
	con, err := net.Dial("tcp", remote)
	// 发送我们的消息，一个http GET请求
	io.WriteString(con, msg)
	// 读取服务器的响应
	for read {
		count, err = con.Read(data)
		read = (err == nil)
		fmt.Printf(string(data[0:count]))
	}
	con.Close()
}

//-----------------------------------------------------------------------------
//

//-----------------------------------------------------------------------------
//

//-----------------------------------------------------------------------------
//

//-----------------------------------------------------------------------------
//

//-----------------------------------------------------------------------------
//

//-----------------------------------------------------------------------------
//
