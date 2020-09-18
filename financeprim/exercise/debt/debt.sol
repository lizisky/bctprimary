/******************************************************************************
File name   : lending.sol
Author      : Kevin Zhang
Vendor      : 粒子区块链(http://liziblockchain.com)
Location    : https://github.com/liziblockchain/bctprimary/
Description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
******************************************************************************/
// SPDX-License-Identifier: GPLv3

pragma solidity >=0.6.0 <0.7.0;

contract Lending {

    // address owner;
    // 抵押的gold与借款的dollar之间的比例
    uint256 ratio;

    // // 借款人
    // struct Borrower {
    //     uint256 amount;
    // }

    // 债权人
    struct Loaner {
        address loaner; // 债权人地址
        uint256 amount; // 债权人可以借出的dollar总数
    }

    // 一笔抵押借贷账目
    struct Debt {
        //address borrower; // 借款人
        address loaner;   // 债权人
        uint256 gold;     // 抵押的黄金数量(克)
        uint256 dollar;   // 借出的美元数量
    }

    // 抵押借贷账目数据
    // key=借款人   value=一笔抵押借贷账目
    mapping(address => Debt) debtMap;
    // 债权人的dollar借给谁了, key=债权人   value=借款人
    mapping(address => address) loanBorrowerMap;
    // 放贷人的放贷数额。key=放贷人地址   value=放贷总数
    // mapping(address => uint256) loanMap;
    // 保存债权人以及可以借出的dollar总数的数组
    Loaner[] loanerAry;

    constructor() public {
        // owner = msg.sender;
        ratio = 10;
    }

    // 放贷的人，设置自己的放贷数额
    function setLoanAmount(uint256 loan) public {
        require(loan > 0, "放贷数量必须大于0");
//        require(loanMap[msg.sender] == 0, "你已经设置过放贷的数量了");

        // loanMap[msg.sender] = loan;
        for (uint i = 0; i < loanerAry.length; i++) {
            if (loanerAry[i].loaner == msg.sender) {
                require(loanerAry[i].loaner != msg.sender, "你已经设置过放贷的数量了");
            }
        }

        Loaner memory newloan = Loaner(msg.sender, loan);
        loanerAry.push(newloan);
    }

    // 辅助方法，查看自己的放贷数额
    function getLoanAmount() public view returns(uint256) {
        // return loanMap[msg.sender];
        for (uint i = 0; i < loanerAry.length; i++) {
            if (loanerAry[i].loaner == msg.sender) {
                return loanerAry[i].amount;
            }
        }

        return 0;
    }

    // 借款人，输入自己能够抵押的黄金数量（克）获取抵押
    function borrow(uint256 gold) public {
        require(gold > 0, "抵押的黄金数量必须大于0");
        require(debtMap[msg.sender].gold == 0, "你已经贷款了，还没有还呢");
        matching(msg.sender, gold);
    }

    // 在债权人可放贷的数组中，寻找合适金额来放贷
    function matching(address addr, uint256 gold) private returns(bool) {
        uint256 dolr = gold * ratio; // 能够贷款的金额等于抵押的黄金乘以贷款率
        for (uint i = 0; i < loanerAry.length; i++) {
            if (loanerAry[i].amount > dolr) {

                loanBorrowerMap[loanerAry[i].loaner] = addr;

                debtMap[addr].loaner = loanerAry[i].loaner;
                debtMap[addr].gold = gold;
                debtMap[addr].dollar = dolr;

                loanerAry[i].amount -= dolr;

                return true;
            }
        }

        return false;
    }

    // 查看我自己的借贷信息
    function getMyDebt() public view returns(address, uint256, uint256) {
        address addr = msg.sender;
        require(debtMap[addr].gold > 0, "你没有任何借款");
        return (debtMap[addr].loaner, debtMap[addr].gold, debtMap[addr].dollar);
    } 
}
