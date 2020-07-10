/******************************************************************************
file name   : struct.go
author      : Kevin Zhang
vendor      : 北京粒子时代科技有限公司(http://liziblockchain.com)
location    : https://github.com/liziblockchain/bctprimary/
description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
******************************************************************************/

package main

import (
	"encoding/json"
	"fmt"
)

func main() {
	basicStruct()
	testMemory()
	testLink()
	testTag()
	testAnonyField()
	testEmbedStruct()
	testConflict()
	testStructMethod()
	testNonStructMethod()
	testValueRecv()
}

// 基本结构体定义
func basicStruct() {

	// 结构体定义
	type person struct {
		Name    string
		Age     int
		Address string
	}

	// 简单结构体
	type T struct{ a, b int }

	var per person
	per.Name = "hello"
	fmt.Println(per)

	var tom *person = new(person)
	tom.Name = "tom"
	fmt.Println(tom)

	kate := &person{"kate", 18, "BJ"}
	fmt.Println(kate)
}

// 内存布局
func testMemory() {
	type Point struct{ x, y int }
	type Rect1 struct{ Min, Max Point }
	type Rect2 struct{ Min, Max *Point }

	var rc1 Rect1 = Rect1{Point{1, 1}, Point{100, 100}}
	var rc2 *Rect2 = &Rect2{&Point{1, 1}, &Point{100, 100}}

	fmt.Println(rc1, rc2)
}

// 链表
func testLink() {
	type Node struct {
		data float64
		su   *Node
	}

	tail := &Node{1.0, nil}
	data := &Node{2.0, tail}
	head := &Node{3.0, data}

	fmt.Println(head)
}

// 思考题

func excerise() {
	type Tree struct {
		le   *Tree
		data float64
		ri   *Tree
	}
}

// 结构体工厂
type File struct {
	fd   int    // 文件描述符
	name string // 文件名
}

func NewFile(fd int, name string) *File {
	if fd < 0 {
		return nil
	}

	return &File{fd, name}
}

func testFactory() {
	f := NewFile(10, "./test.txt")
	fmt.Println(f)
}

// new & make
func testNewMake() {

	type Foo map[string]string
	type Bar struct {
		thingOne string
		thingTwo int
	}

	// OK
	y := new(Bar)
	(*y).thingOne = "hello"
	(*y).thingTwo = 1

	// NOT OK
	// z := make(Bar) // 编译错误：cannot make type Bar
	// (*z).thingOne = "hello"
	// (*z).thingTwo = 1

	// OK
	x := make(Foo)
	x["x"] = "goodbye"
	x["y"] = "world"

	// NOT OK
	u := new(Foo)
	(*u)["x"] = "goodbye" // 运行时错误!! panic: assignment to entry in nil map
	(*u)["y"] = "world"
}

// tag
func testTag() {
	type User struct {
		ID       int64  `json:"aid,omitempty"`
		Password string `json:"pwd,omitempty"`
		Salt     string `json:"-"`
	}

	user := &User{1234, "password", "salt"}
	jstr, _ := json.Marshal(user)
	fmt.Println(string(jstr))
}

// 匿名字段
func testAnonyField() {
	type innerS struct {
		in1 int
		in2 int
	}

	type outerS struct {
		b      int
		c      float32
		int    // anonymous field
		innerS //anonymous field
	}

	outer := new(outerS)
	outer.b = 6
	outer.c = 7.5
	outer.int = 60
	outer.in1 = 5
	outer.in2 = 10

	fmt.Printf("outer.b is: %d\n", outer.b)
	fmt.Printf("outer.c is: %f\n", outer.c)
	fmt.Printf("outer.int is: %d\n", outer.int)
	fmt.Printf("outer.in1 is: %d\n", outer.in1)
	fmt.Printf("outer.in2 is: %d\n", outer.in2)

	// 使用结构体字面量
	outer2 := outerS{6, 7.5, 60, innerS{5, 10}}
	fmt.Println("outer2 is:", outer2)

}

func testEmbedStruct() {
	type A struct {
		ax, ay int
	}

	type B struct {
		A
		bx, by float32
	}

	b := B{A{1, 2}, 3.0, 4.0}
	fmt.Println(b.ax, b.ay, b.bx, b.by)
	fmt.Println(b.A)
}

func testConflict() {
	type A struct{ a int }
	type B struct{ a, b int }

	type C struct {
		A
		B
	}
	var c C

	c.A.a = 1
	c.B.a = 2
	c.b = 3
	fmt.Println(c)

	type D struct {
		B
		b float32
	}
	var d D
	d.b = 1
	d.B.b = 2
	fmt.Println(d)

}

// 结构体
type TwoInts struct {
	a int
	b int
}

// 结构体方法
func (tn *TwoInts) Sum() int {
	return tn.a + tn.b
}

// 结构体方法
func testStructMethod() {
	two := TwoInts{1, 2}
	fmt.Println(two.Sum())
}

type IntVector []int

func (v IntVector) Sum() (s int) {
	for _, x := range v {
		s += x
	}
	return
}

// 非结构体类型方法
func testNonStructMethod() {
	iv := &IntVector{1, 2, 3}
	fmt.Println(iv.Sum()) // 输出是6
}

type Obj struct {
	thing int
}

func (b *Obj) change() { b.thing++ }
func (b Obj) write() {
	b.thing++
	fmt.Println("in write method:", b.thing)
}

// 指针或值作为接收者
func testValueRecv() {
	obj := Obj{1}
	obj.change()
	fmt.Println(obj)
	obj.write()
	fmt.Println(obj)
}
