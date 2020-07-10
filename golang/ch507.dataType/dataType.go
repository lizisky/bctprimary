/******************************************************************************
file name   : dataType.go
author      : Kevin Zhang
vendor      : 北京粒子时代科技有限公司(http://lizitime.com)
location    : https://github.com/liziblockchain/bctprimary/
description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
******************************************************************************/

package main

import "fmt"

func main() {
	tryDatatypes()
}

func tryDatatypes() {
	testString()
	testArray()
	testSlice()
	testSliceGrow()
	testMap()
}

// 字符串
func testString() {
	var str string     // 声明一个字符串变量
	str = "Hello字符串赋值" // 字符串赋值
	ch := str[0]       // 取字符串的第一个字符

	// 错误用法
	hello := "Hello world"
	// hello[0] = 'X' // 编译错误

	fmt.Println(str, ch, hello)

	n := len(hello)
	for i := 0; i < n; i++ {
		ch := hello[i]
		fmt.Println(i, ch)
	}

	for i, ch2 := range str {
		fmt.Println(i, ch2) //ch2的类型为rune
	}

}

// 数组
func testArray() {
	// var v0 [32]byte
	// var point [2 * N]struct{ x, y int32 }
	// var v1 [1000]*float64
	var v2 [3]int = [3]int{0, 1, 2}
	// var v3 [2][2][2]float64
	var length int = len(v2)

	for i := 0; i < length; i++ {
		fmt.Println("Element", i, "of array is", v2[i])
	}

	for i, v := range v2 {
		fmt.Println("Array element[", i, "]=", v)
	}

}

// 切片
func testSlice() {

	var myArray [10]int = [10]int{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
	// 基于数组创建一个数组切片
	var mySlice0 []int = myArray[:2]
	// var mySlice1 []int = myArray[5:]
	// var mySlice2 []int = myArray[2:5]
	// var mySlice3 []int = myArray[:]

	// mySlice4 := make([]int, 5)

	fmt.Println(mySlice0)
}

// slice动态增加元素
func testSliceGrow() {

	mySlice := make([]int, 5, 10)
	mySlice = append(mySlice, 1, 2, 3)

	fmt.Println(mySlice)
}

// 元素个数与容量
func lenCap() {
	var v2 [3][5]int
	mySlice := make([]int, 5, 10)

	fmt.Println("length is:", len(v2))
	fmt.Println("length is:", len(mySlice))

	fmt.Println("length is:", cap(v2))
	fmt.Println("length is:", cap(mySlice))

}

// map
func testMap() {
	// var score map[string]int
	score2 := make(map[string]int, 10)
	score2["kevin"] = 80

	value, ok := score2["kevin"]
	if ok { // 找到了
		fmt.Println(value) // 处理找到的value
	} else {
		fmt.Println("没有找到")
	}

	delete(score2, "kevin")

	for key, value := range score2 {
		fmt.Println(key, value)
	}
}
