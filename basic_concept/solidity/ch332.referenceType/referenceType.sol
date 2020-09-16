/******************************************************************************
File name   : referenceType.sol
Author      : Kevin Zhang
Vendor      : 粒子区块链(http://liziblockchain.com)
Location    : https://github.com/liziblockchain/bctprimary/
Description : 工业和信息化部-区块链基础理论课程（初级）培训教程配套源码
******************************************************************************/
// SPDX-License-Identifier: GPLv3

pragma solidity ^0.6.0;

// Array
contract DeclareArray {
  // type[arraySize] arrayName ;

  uint[10] balance;
}

// Init Array
contract InitArray {
  uint[10] balance;

  function test() public pure returns (uint) {
    uint8[3] memory balance2 = [1, 2, 3];
    uint8 ret = balance2[0];
    return ret;
  }
}

// 创建内存数组
contract MemoryAry {
    function fn(uint len) pure public {
        uint[] memory a = new uint[](7);
        bytes memory b = new bytes(len);
        // a.length == 7, b.length == len
        a[6] = 8;
    }
}

// 数组成员
contract ArrayContract {

    uint[2**5] m_aLotOfIntegers;
    bool[2][] m_pairsOfFlags;
    bytes m_byteData;

    // length && push(x)
    function addFlag(bool[2] memory flag) public returns (uint)  {
        m_pairsOfFlags.push(flag);
        return m_pairsOfFlags.length;
    }

    // push()
    function byteArrays(bytes memory data) public {
        // byte 数组 ("bytes") 存储时没有填充(padding),
        // 但是可以与“uint8[]”相同处理
        m_byteData = data;
        m_byteData.push();
        m_byteData[3] = '8';
        delete m_byteData[2];
    }

    // pop()
    function topFlag() public view {
        m_byteData.pop;
    }


    function clear() public {
        // 完全清除数组
        delete m_pairsOfFlags;
        delete m_aLotOfIntegers;
    }

    function createMemoryArray(uint size) public pure returns (bytes memory) {
        // 使用“new”创建动态内存数组:
        // uint[2][] memory arrayOfPairs = new uint[2][](size);
        // 创建一个动态byte数组:
        bytes memory b = new bytes(size);
        for (uint8 i = 0; i < b.length; i++)
            b[i] = byte(i);

        return b;
    }
}

// struct
contract structContract {
   struct Book {
      string title;
      string author;
      uint book_id;
   }
   Book book;

   function setBook() public {
      book = Book('Learn Java', 'TP', 1);
   }
   function getBookId() public view returns (uint) {
      return book.book_id;
   }
}

// mapping
contract LedgerBalance {
   mapping(address => uint) public balances;

   function updateBalance(uint newBalance) public {
      balances[msg.sender] = newBalance;
   }
}

contract Updater {
   function updateBalance() public returns (uint) {
      LedgerBalance ledgerBalance = new LedgerBalance();
      ledgerBalance.updateBalance(10);
      return ledgerBalance.balances(address(this));
   }
}
