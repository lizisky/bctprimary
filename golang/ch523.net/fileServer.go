/******************************************************************************
file name   : fileServer.go
author      : Kevin Zhang
vendor      : 北京粒子时代科技有限公司(http://lizitime.com)
location    : https://github.com/liziblockchain/bctprimary/
description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
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
