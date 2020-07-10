/******************************************************************************
file name   : variable.go
author      : Kevin Zhang
vendor      : 北京粒子时代科技有限公司(http://lizitime.com)
location    : https://github.com/liziblockchain/bctprimary/
description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
******************************************************************************/

package main

import "fmt"

// import "os"

func main() {
	tryVariables()
}

func tryVariables() {
	defineVar()
	initializeVar()
	testAnony()
	testConstant()
	testPredefined()
	// fmt.Println("Hello, 世界!")
}

// 变量声明
func defineVar() {
	var v1 int
	var v2 string
	var v3 [10]int
	var v4 []int
	var (
		v6 *int
		v7 map[string]int
		v8 func(a int) int
	)

	v1 = 3
	v2 = "hello"
	v3[0] = 6
	v4 = make([]int, 10)
	v6 = &v1
	v7 = make(map[string]int)
	v8 = func(a int) int {
		return a + 1
	}

	fmt.Println(v2, v4, v6, v7, v8)
}

// 变量初始化
func initializeVar() {
	var v1 int = 10
	var v2 = 11
	v3 := 12

	fmt.Println(v1, v2, v3)
}

// 匿名变量
func testAnony() {

	// getname := func GetName() (firstName, lastName, nickName string) {
	getname := func() (firstName, lastName, nickName string) {
		return "May", "Chan", "Chibi Maruko"
	}

	_, _, nickName := getname()

	fmt.Println(nickName)
}

// 常量定义
func testConstant() {
	const Pi float64 = 3.1415926
	const zero = 0.0 // 无类型浮点常量
	const (
		size int64 = 1024
		eof        = -1 // 无类型整型常量
	)
	const u, v float32 = 0, 3   // u = 0.0, v = 3.0，常量的多重赋值
	const a, b, c = 3, 4, "foo" // a = 3, b = 4, c = "foo", 无类型整型和字符串常量
	const mask = 1 << 3

	// const Home = os.Getenv("HOME")

	fmt.Println(Pi, zero, size, eof, u, v, a, b, c, mask)
}

// 预定义常量 & 枚举
func testPredefined() {
	const (
		Sunday = iota
		Monday
		Tuesday
		Wednesday
		Thursday
		Friday
		Saturday
	)
	const x = iota // x == 0 (因为iota又被重设为0了)
	const y = iota // y == 0 (同上)

	fmt.Println(Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, x, y)
}
