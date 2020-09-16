/******************************************************************************
File name   : fileServer.go
Author      : Kevin Zhang
Vendor      : 粒子区块链(http://liziblockchain.com)
Location    : https://github.com/liziblockchain/bctprimary/
Description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
******************************************************************************/

package main

import (
	"encoding/json"
	"fmt"
)

type User struct {
	ID      int64
	Name    string
	Passwd  string
	Address string
}

// type User struct {
// 	ID      int64  `json:"id"`
// 	Name    string `json:"name"`
// 	Passwd  string `json:"-"`
// 	Address string `json:"addr,omitempty"`
// }

func main() {

	tom := User{123, "tom", "password", "#23 street"}
	jstr, _ := json.Marshal(tom)
	fmt.Println(string(jstr))

	tom2 := &User{}
	json.Unmarshal(jstr, tom2)
	fmt.Println(tom2)
}
