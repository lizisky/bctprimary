/******************************************************************************
File name   : basicHttpServer.go
Author      : Kevin Zhang
Vendor      : 粒子区块链(http://liziblockchain.com)
Location    : https://github.com/liziblockchain/bctprimary/
Description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
******************************************************************************/

package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
)

func main() {
	res, err := http.Get("http://www.google.com")
	data, err := ioutil.ReadAll(res.Body)
	if err != nil {
		fmt.Println("read error:", err.Error())
	}
	fmt.Printf("Got: %q", string(data))
}
