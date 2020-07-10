/******************************************************************************
file name   : controlFlow.go
author      : Kevin Zhang
vendor      : 北京粒子时代科技有限公司(http://liziblockchain.com)
location    : https://github.com/liziblockchain/bctprimary/
description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
******************************************************************************/

package main

import "fmt"

func main() {
	testCondition(3)
	testSelection(6)
	testFor()
	testGoto()
	// fmt.Println("Hello, 世界!")
}

// 条件语句
func testCondition(a int) int {
	if a < 5 {
		fmt.Println("a < 5")
		return 1
	} else {
		fmt.Println("a >= 5")
		return 2
	}

	return 0
}

// 选择语句
func testSelection(condition int) {
	switch condition {
	case 0:
		fmt.Printf("0")
	case 1:
		fmt.Printf("1")
	case 2:
		fallthrough
	case 3:
		fmt.Printf("3")
	case 4, 5, 6:
		fmt.Printf("4, 5, 6")
	default:
		fmt.Printf("Default")
	}

	switch {
	case 0 <= condition && condition <= 3:
		fmt.Printf("0-3")
	case 4 <= condition && condition <= 6:
		fmt.Printf("4-6")
	case 7 <= condition && condition <= 9:
		fmt.Printf("7-9")
	}
}

// 循环语句
func testFor() {
	sum := 0
	for i := 0; i < 10; i++ {
		sum += i
	}

	sum = 0
	for {
		sum++
		if sum > 100 {
			break
		}
	}

	a := []int{1, 2, 3, 4, 5, 6}
	for i, j := 0, len(a)-1; i < j; i, j = i+1, j-1 {
		a[i], a[j] = a[j], a[i]
	}

	// JLoop:

	for j := 0; j < 5; j++ {
		for i := 0; i < 10; i++ {
			if i > 5 {
				break
				//				break JLoop
			}
			fmt.Println(i)
		}
	}

	for i := 0; i < 10; i++ {
		if i > 5 {
			continue
			fmt.Println(i)
		}
	}

}

func testGoto() {
	i := 0
HERE:
	fmt.Println(i)
	i++
	if i < 10 {
		goto HERE
	}
	fmt.Println("exit goto HERE")
}
