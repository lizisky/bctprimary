/******************************************************************************
file name   : function.go
author      : Kevin Zhang
vendor      : 北京粒子时代科技有限公司(http://lizitime.com)
location    : https://github.com/lizitime/bctprimary/
description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
******************************************************************************/

package main

import (
	"errors"
	"fmt"
	"io"
	"log"
	"os"
)

func main() {
	Add(1, 2)

	myfunc(2, 3, 4)
	myfunc(1, 3, 7, 13)

	printArgs(1, 2, 3, 4, 5)

	ages := []int{10, 11, 12}
	printAnyType(1, "hello world", 18.3, ages)

	_, _, nickName := GetName()
	printAnyType(nickName)

	testAnonyFunc()

	closure()

	testError()
}

// 基本函数定义
func Add(a int, b int) (ret int, err error) {
	if a < 0 || b < 0 { // 假设这个函数只支持两个非负数字的加法
		err = errors.New("Should be non-negative numbers!")
		return
	}
	return a + b, nil // 支持多重返回值
}

// 不定参数
func myfunc(args ...int) {
	for _, arg := range args {
		fmt.Println(arg)
	}
}

// 不定参数的传递
func myfunc3(args ...int) {
	fmt.Println(args)
}

// 不定参数的传递
func printArgs(args ...int) {
	myfunc3(args...)
	myfunc3(args[1:]...)
}

// 任意类型的不定参数
func printAnyType(args ...interface{}) {
	for _, arg := range args {
		switch arg.(type) {
		case int:
			fmt.Println(arg, "is an int value.")
		case string:
			fmt.Println(arg, "is a string value.")
		case int64:
			fmt.Println(arg, "is an int64 value.")
		default:
			fmt.Println(arg, "is an unknown type.")
		}
	}
}

// 多返回值
func GetName() (firstName, lastName, nickName string) {
	return "May", "Chan", "Chibi Maruko"
}

// 匿名函数
func testAnonyFunc() {
	addArgs := func(x, y int) int {
		return x + y
	}

	addArgs(1, 2)

	func(a, b int) {
		fmt.Println(a, b)
	}(1, 2)
}

// 闭包
func closure() {
	var j int = 5

	a := func() func() {
		var i int = 10
		return func() {
			fmt.Printf("i, j: %d, %d\n", i, j)
		}
	}()

	a()

	j *= 2
	a()
}

// error 接口
func testError() {
	foo := func(param int) (n int, err error) {
		if param > 0 {
			return param, nil
		}
		return -param, errors.New("参数必须非负整数")
	}

	_, err := foo(0)
	if err != nil {
		// 错误处理
	} else {
		// 使用返回值n
	}

}

// no defer
func CopyFileTradition(dst, src string) (w int64, err error) {
	srcFile, err := os.Open(src)
	if err != nil {
		return
	}

	dstFile, err := os.Create(dst)
	if err != nil {
		dstFile.Close()
		return
	}

	written, err := io.Copy(dstFile, srcFile)

	defer srcFile.Close()
	defer dstFile.Close()

	return written, err
}

// defer
func CopyFileDefer(dst, src string) (w int64, err error) {
	srcFile, err := os.Open(src)
	if err != nil {
		return
	}
	defer srcFile.Close()

	dstFile, err := os.Create(dst)
	if err != nil {
		return
	}
	defer dstFile.Close()

	return io.Copy(dstFile, srcFile)
}

// deferFunc
func deferFunc(dst, src string) (w int64, err error) {
	srcFile, err := os.Open(src)
	if err != nil {
		return
	}
	defer func() {
		fmt.Println("打开源文件失败")
		srcFile.Close()
	}()

	dstFile, err := os.Create(dst)
	if err != nil {
		return
	}
	defer func() {
		fmt.Println("打开目标失败")
		dstFile.Close()
	}()

	return io.Copy(dstFile, srcFile)
}

// panic()和recover()
func testRecover() {
	defer func() {
		if r := recover(); r != nil {
			log.Printf("Runtime error caught: %v", r)
		}
	}()

	foo := func(div int) int {
		if div == 0 {
			panic("除数不能等于0")
		}
		return 1 / div
	}

	foo(0)
}
