/******************************************************************************
file name   : auction.sol
author      : Kevin Zhang
vendor      : 北京粒子时代科技有限公司(http://liziblockchain.com)
location    : https://github.com/liziblockchain/bctprimary/
description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
******************************************************************************/
// SPDX-License-Identifier: GPLv3

pragma solidity ^0.6.0;

contract Auction {
    // 拍卖的参数，商品拍卖人的地址
    address payable owner;
    // 时间是unix的绝对时间戳（自1970-01-01以来的秒数）, 以秒为单位
    uint endTime;  // 拍卖截止时间

    // 拍卖的当前状态
    address highestBidder; // 最高竞价者的地址
    uint highestBid;       // 最高竞价者

    //可以取回的之前的出价
    mapping(address => uint) pendingReturns;

    // 拍卖结束后设为 true，将禁止所有的变更
    bool ended;

    // 变更触发的事件
    event HighestBidIncreased(address bidder, uint amount);
    event AuctionEnded(address winner, uint amount);

    /// 创建一个简单的拍卖，拍卖时间为 `_timeout` 秒。
    constructor(uint _timeout) public {
        endTime = now + _timeout;
        owner = msg.sender;
    }

    /// 对拍卖进行出价，具体的出价随交易一起发送。
    /// 如果没有在拍卖中胜出，则返还出价。
    function bid() public payable {
        // 参数不是必要的。因为所有的信息已经包含在了交易中。
        // 对于能接收以太币的函数，关键字 payable 是必须的。

        // 如果拍卖已结束，撤销函数的调用。
        require(
            now <= endTime,
            "拍卖已经结束了！"
        );

        // 如果出价不够高，返还你的钱
        require(
            msg.value > highestBid,
            "你的出价太低了，已经有别人的出价比你更高"
        );

        require(
            msg.sender != owner,
            "卖家就不要参与出价了吧"
        );

        if (highestBid != 0) {
            // 返还出价时，简单地直接调用 highestBidder.send(highestBid) 函数，
            // 是有安全风险的，因为它有可能执行一个非信任合约。
            // 更为安全的做法是让接收方自己提取金钱。
            pendingReturns[highestBidder] += highestBid;
        }
        highestBidder = msg.sender;
        highestBid = msg.value;
        emit HighestBidIncreased(msg.sender, msg.value);
    }

    /// 取回出价（当该出价已被超越）
    function withdraw() public returns (bool) {
        uint amount = pendingReturns[msg.sender];
        if (amount > 0) {
            // 这里很重要，首先要设零值。
            // 因为，作为接收调用的一部分，
            // 接收者可以在 `send` 返回之前，重新调用该函数。
            pendingReturns[msg.sender] = 0;

            if (!msg.sender.send(amount)) {
                // 这里不需抛出异常，只需重置未付款
                pendingReturns[msg.sender] = amount;
                return false;
            }
        }
        return true;
    }

    /// 结束拍卖，并把最高的出价发送给受益人
    function auctionEnd() public {
        // 对于可与其他合约交互的函数（意味着它会调用其他函数或发送以太币），
        // 一个好的指导方针是将其结构分为三个阶段：
        // 1. 检查条件
        // 2. 执行动作 (可能会改变条件)
        // 3. 与其他合约交互
        // 如果这些阶段相混合，其他的合约可能会回调当前合约并修改状态，
        // 或者导致某些效果（比如支付以太币）多次生效。
        // 如果合约内调用的函数包含了与外部合约的交互，
        // 则它也会被认为是与外部合约有交互的。

        // 1. 条件
        require(now >= endTime, "Auction not yet ended.");
        require(!ended, "auctionEnd has already been called.");

        // 2. 生效
        ended = true;
        emit AuctionEnded(highestBidder, highestBid);

        // 3. 交互
        owner.transfer(highestBid);
    }

    /// 辅助函数，看看当前的最高竞价是多少
    function getBid() public view returns(uint) {
        return highestBid;
    }

    /// 辅助函数，看看当前的最高竞者是谁
    function getBidder() public view returns(address) {
        return highestBidder;
    }

    /// 辅助函数，拍卖是否已经结束
    function isEnded() public view returns(bool) {
        return ended;
    }

    /// 辅助函数，拍卖还剩余多少时间，以秒为单位
    /// 注意：这里仅仅是一个辅助函数，是不严谨的。
    /// 超过拍卖时间之后，endTime - now 将是一个负值，由于返回值是uint，所以实际上的效果是溢出了
    function getRemainTime() public view returns(uint) {
        return endTime - now;
    }

    /// 辅助函数，看看拍卖人是谁
    function getowner() public view returns(address) {
        return owner;
    }

    /// 辅助函数，看某一个人他前面的竞价资金数量
    function getPendingReturns(address addr) public view returns(uint) {
        return pendingReturns[addr];
    }

}
