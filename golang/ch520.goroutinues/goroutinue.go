/******************************************************************************
file name   : goroutinue.go
author      : Kevin Zhang
vendor      : 北京粒子时代科技有限公司(http://liziblockchain.com)
location    : https://github.com/liziblockchain/bctprimary/
description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
******************************************************************************/

package main

import (
	"fmt"
	"sync"
	"time"
)

func main() {
	// testBasicGoroutine()
	// tryChannel()
	// tryTimeout()
	// trySingleDirectChannel()
	// tryMutex()
	// tryRWMutex()
	twoprint()
}

//-----------------------------------------------------------------------------
// goroutinue的基本实现方法
func Add(x, y int) {
	z := x + y
	fmt.Println(z)
}

func testBasicGoroutine() {
	for i := 0; i < 10; i++ {
		go Add(i, i)
	}
}

//-----------------------------------------------------------------------------
// channel
func add(i int, ch chan int) int {
	defer func() {
		ch <- 1
	}()
	fmt.Println("Counting:", i)
	return i + i
}

func tryChannel() {
	chs := make([]chan int, 10)
	for i := 0; i < 10; i++ {
		chs[i] = make(chan int)
		go add(i, chs[i])
	}
	for _, ch := range chs {
		<-ch
	}
}

//-----------------------------------------------------------------------------
// 超时机制

func tryTimeout() {
	// 首先，我们实现并执行一个匿名的超时等待函数
	timeout := make(chan bool, 1)
	ch := make(chan struct{})

	go func() {
		time.Sleep(1e9) // 等待1秒钟
		timeout <- true
	}()

	// 然后我们把timeout这个channel利用起来
	select {
	case <-ch:
		// 从ch中读取到数据
	case <-timeout:
		// 一直没有从ch中读取到数据，但从timeout中读取到了数据
		fmt.Println("received timeout")
	}
}

//-----------------------------------------------------------------------------
// 单向channel
func raise(ch chan<- int) {
	ch <- 10
}

func parse(ch <-chan int) {
	value := <-ch
	fmt.Println("get value", value)
}

func trySingleDirectChannel() {
	var ch1 chan int // ch1是一个正常的channel，不是单向的
	ch1 = make(chan int)
	go raise(ch1)
	parse(ch1)
}

//-----------------------------------------------------------------------------
// 同步锁
func tryMutex() {
	var id int = 0
	var mutex *sync.Mutex = new(sync.Mutex)
	go func() {
		mutex.Lock()
		defer mutex.Unlock()
		id++
	}()
}

//-----------------------------------------------------------------------------
// RWMutex
func tryRWMutex() {
	var id int = 0
	var mu *sync.RWMutex = new(sync.RWMutex)

	read := func() {
		mu.RLock()
		defer mu.RUnlock()
		println("reading", id)
		time.Sleep(1 * time.Second)
	}

	write := func() {
		mu.Lock()
		defer mu.Unlock()
		id++
		println("writing", id)
		time.Sleep(1 * time.Second)
	}
	// 写的时候啥也不能干
	go read()
	go write()
	go read()

	time.Sleep(3 * time.Second)
}

//-----------------------------------------------------------------------------
//全局唯一性操作
var a string
var once sync.Once

func setup() {
	a = "hello, world\n"
}
func doprint() {
	once.Do(setup)
	print(a)
}
func twoprint() {
	go doprint()
	go doprint()
}

//-----------------------------------------------------------------------------
//

//-----------------------------------------------------------------------------
//

//-----------------------------------------------------------------------------
//

//-----------------------------------------------------------------------------
//
