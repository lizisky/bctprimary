/******************************************************************************
file name   : basicHttpServer.go
author      : Kevin Zhang
vendor      : 北京粒子时代科技有限公司(http://lizitime.com)
location    : https://github.com/lizitime/bctprimary/
description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
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
