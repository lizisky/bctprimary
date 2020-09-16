/******************************************************************************
File name   : vote.sol
Author      : Kevin Zhang
Vendor      : 粒子区块链(http://liziblockchain.com)
Location    : https://github.com/liziblockchain/bctprimary/
Description : 工业和信息化部-区块链应用工程师（初级）培训教程配套源码
******************************************************************************/
// SPDX-License-Identifier: GPLv3

pragma solidity >=0.6.0 <0.7.0;

/// @title 委托投票
contract Ballot {
    // 这里声明了一个struct类型用于稍后的变量，它用来表示一个选民
    struct Voter {
        uint weight; // 计票的权重
        bool voted;  // true代表该人已投票
        address delegate; // 被委托人
        uint vote;   // 投票候选人的索引
    }

    // 候选人
    struct Candidate {
        bytes32 name;   // 简称（最长32个字节）
        uint voteCount; // 得票数
    }

    address public chairMan; // 主席

    // 这声明了一个状态变量，为每个可能的地址存储一个 `Voter`，即：投票人列表
    mapping(address => Voter) public voterList;

    // 一个 `Candidate` 结构类型的动态数组，所有的候选人列表
    Candidate[] public candidateList;

    // 构造函数
    constructor() public {
        chairMan = msg.sender;
    }

    // 新增一个候选人
    function addCandidateName(bytes4 cname) public {
        candidateList.push(Candidate({
            name: cname,
            voteCount: 0
        }));
    }

    // 授权 `voter` 拥有投票权
    // 只有 `chairMan` 可以调用该函数。
    function giveRightToVote(address voter) public {
        // 若 `require` 的第一个参数的计算结果为 `false`，
        // 则终止执行，撤销所有对状态和以太币余额的改动。
        // 在旧版的 EVM 中这曾经会消耗所有 gas，但现在不会了。
        // 使用 require 来检查函数是否被正确地调用，是一个好习惯。
        // 你也可以在 require 的第二个参数中提供一个对错误情况的解释。
        require(
            msg.sender == chairMan,
            "Only chairMan can give right to vote."
        );
        require(
            !voterList[voter].voted,
            "The voter already voted."
        );
        require(voterList[voter].weight == 0);
        voterList[voter].weight = 1;
    }

    /// 把你的投票委托到投票者 `to`。
    function delegate(address to) public {
        // 传引用
        Voter storage sender = voterList[msg.sender];
        require(!sender.voted, "You already voted.");

        require(to != msg.sender, "Self-delegation is disallowed.");

        // `sender` 是一个引用, 相当于对 `voterList[msg.sender].voted` 进行修改
        sender.voted = true;
        sender.delegate = to;
        Voter storage delegate_ = voterList[to];
        if (delegate_.voted) {
            // 若被委托者已经投过票了，直接增加得票数
            candidateList[delegate_.vote].voteCount += sender.weight;
        } else {
            // 若被委托者还没投票，增加委托者的权重
            delegate_.weight += sender.weight;
        }
    }

    /// 给候选人投票
    /// 投给提案 `candidateList[idx].name`.
    function vote(uint idx) public {
        Voter storage sender = voterList[msg.sender];
        require(!sender.voted, "Already voted.");
        sender.voted = true;
        sender.vote = idx;

        // 如果 `idx` 超过了数组的范围，则会自动抛出异常，并恢复所有的改动
        candidateList[idx].voteCount += sender.weight;
    }

    /// @dev 结合之前所有的投票，计算出最终胜出的提案
    function winningCandidate() public view returns (uint winningCandidate_)
    {
        uint winningVoteCount = 0;
        for (uint p = 0; p < candidateList.length; p++) {
            if (candidateList[p].voteCount > winningVoteCount) {
                winningVoteCount = candidateList[p].voteCount;
                winningCandidate_ = p;
            }
        }
    }

    // 调用 winningCandidate() 函数以获取提案数组中获胜者的索引，并以此返回获胜者的名称
    function winnerName() public view returns (bytes32 winnerName_)
    {
        winnerName_ = candidateList[winningCandidate()].name;
    }

    // 查看现在总共有多少个候选人
    function candidateCount() public view returns (uint) {
        return candidateList.length;
    }

    // 查看每个候选人当前的情况
    function getCandidate(uint idx) public view returns(bytes32, uint) {
        require(idx < candidateList.length, "invalidate index");
        return (candidateList[idx].name, candidateList[idx].voteCount);
    }

    // 查看选举人的情况
    function getVoter(address addr) public view returns(uint, bool, address, uint) {
        Voter memory voter = voterList[addr];
        return (voter.weight, voter.voted, voter.delegate, voter.vote);
    }

}
