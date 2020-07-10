/******************************************************************************
file name   : helloWorld.go
author      : Kevin Zhang
vendor      : 北京粒子时代科技有限公司(http://liziblockchain.com)
location    : https://github.com/liziblockchain/bctprimary/
description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
******************************************************************************/

package main

import "fmt"

func main() {
	fmt.Println("Hello, 世界!")
}

// 产生异常的原因
func productException() {

	var pint *int
	*pint = 1

	var intary [5]int
	intary[5] = 1

	var age int = 18
	fmt.Println(age / 0)

	panic(0)
}
