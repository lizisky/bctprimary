/******************************************************************************
file name   : interfa.go
author      : Kevin Zhang
vendor      : 北京粒子时代科技有限公司(http://liziblockchain.com)
location    : https://github.com/liziblockchain/bctprimary/
description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
******************************************************************************/

package main

import (
	"fmt"
	"sort"
)

func main() {
	testSquare()
	testTypeValidation()
	testSwitchType()
}

//=============================================================================
// 实现接口
type Shaper interface {
	Area() float32
}

type Square struct {
	side float32
}

func (sq *Square) Area() float32 {
	return sq.side * sq.side
}

func testSquare() {
	sq1 := new(Square)
	sq1.side = 5

	var areaIntf Shaper = sq1
	fmt.Printf("The square has area: %f\n", areaIntf.Area())
}

//=============================================================================
// 类型断言

type Shaper2 interface {
	Area() float32
}

type Square2 struct {
	side float32
}

func (sq *Square2) Area() float32 {
	return sq.side * sq.side
}

type Circle struct {
	radius float32
}

func testTypeValidation() {
	sq1 := new(Square2)
	sq1.side = 5

	var areaIntf Shaper2
	areaIntf = sq1

	// Is Square the type of areaIntf?
	if t, ok := areaIntf.(*Square); ok {
		fmt.Printf("The type of areaIntf is: %T\n", t)
	}
	// if u, ok := areaIntf.(*Circle); ok {
	//     fmt.Printf("The type of areaIntf is: %T\n", u)
	// }
}

//=============================================================================
// 类型判断：type-switch
func testSwitchType() {

	sq1 := new(Square2)
	sq1.side = 5

	var areaIntf Shaper2
	areaIntf = sq1

	switch t := areaIntf.(type) {
	case *Square:
		fmt.Printf("Type Square %T with value %v\n", t, t)
	// case *Circle:
	// 	fmt.Printf("Type Circle %T with value %v\n", t, t)
	case nil:
		fmt.Printf("nil value: nothing to check?\n")
	default:
		fmt.Printf("Unexpected type %T\n", t)
	}
}

//=============================================================================
//测试一个值是否实现了某个接口
type Stringer interface {
	String() string
}

func testImpl() {
	var v Stringer
	if sv, ok := v.(Stringer); ok {
		fmt.Printf("v implements String(): %s\n", sv.String())
	}
}

//=============================================================================
// 例子：使用 Sorter 接口排序
type Sorter interface {
	Len() int
	Less(i, j int) bool
	Swap(i, j int)
}

type IntArray []int

func (p IntArray) Len() int           { return len(p) }
func (p IntArray) Less(i, j int) bool { return p[i] < p[j] }
func (p IntArray) Swap(i, j int)      { p[i], p[j] = p[j], p[i] }

func testSort() {
	data := IntArray{74, 59, 238, -784, 9845, 959, 905, 0, 0, 42, 7586, -5467984, 7586}
	sort.Sort(data)
}

//=============================================================================
// 空接口

func testAny() {
	type Any interface{}
	type Person struct {
		name string
		age  int
	}

	pers1 := new(Person)
	pers1.age = 18
	var val Any = pers1

	fmt.Println(val)
}

//=============================================================================
// 接口赋值
type Lesser interface {
	Less(b Integer) bool
}

type Integer int

func (a *Integer) Less(b Integer) bool {
	return *a < b
}

func testInterfaceAssign() {
	var age Integer = 18
	var b Lesser = &age
	var c Lesser = b
	fmt.Println(c.Less(5))
}

//=============================================================================
// 接口组合
type IReader interface {
	Read(buf []byte) (n int, err error)
}
type IWriter interface {
	Write(buf []byte) (n int, err error)
}

type ReadWriter interface {
	Reader
	Writer
}

type ReadWriter interface {
	Read(p []byte) (n int, err error)
	Write(p []byte) (n int, err error)
}
