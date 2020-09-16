/******************************************************************************
File name   : fileServer.go
Author      : Kevin Zhang
Vendor      : 粒子区块链(http://liziblockchain.com)
Location    : https://github.com/liziblockchain/bctprimary/
Description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
******************************************************************************/

package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.Handle("/", http.FileServer(http.Dir("/work/")))
	err := http.ListenAndServe("localhost:8080", nil)
	if err != nil {
		fmt.Print(err)
	}
}
