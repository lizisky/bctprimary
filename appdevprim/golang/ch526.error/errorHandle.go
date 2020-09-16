/******************************************************************************
File name   : helloWorld.go
Author      : Kevin Zhang
Vendor      : 粒子区块链(http://liziblockchain.com)
Location    : https://github.com/liziblockchain/bctprimary/
Description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
******************************************************************************/

package main

import "fmt"

func main() {
	fmt.Println("Hello, 世界!")
}

// 产生异常的原因
func produceException() {

	var pint *int
	*pint = 1

	var intary [5]int
	intary[5] = 1 // 数组越界溢出错误

	var age int = 18
	fmt.Println(age / 0) // 除0错

	panic(0)
}
