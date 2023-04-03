//
//  14501_퇴사.swift
//  swift_practise
//
//  Created by Chan on 2023/03/29.
//
//	https://www.acmicpc.net/problem/14501
//
//	MARK: - DP

var n = Int(readLine()!)!
var tp: [[Int]] = []
var dp = Array(repeating: 0, count: 21)

for _ in 0..<n { tp.append(readLine()!.split{$0==" "}.map{ Int(String($0))! }) }

for i in 0..<n {
	if dp[i] > dp[i+1] { dp[i+1] = dp[i] }
	if dp[i+tp[i][0]] < dp[i] + tp[i][1] {dp[i+tp[i][0]] = dp[i] + tp[i][1] }
}

print(dp[n])
