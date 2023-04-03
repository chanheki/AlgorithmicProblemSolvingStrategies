//
//  11055_가장 큰 증가하는 부분 수열.swift
//  swift_practise
//
//  Created by Chan on 2023/03/29.
//
//	https://www.acmicpc.net/problem/11055
//
//	MARK: - DP

let N = Int(readLine()!)!
var n = readLine()!.split(separator: " ").map { Int(String($0))!}
var dp = [0] + n

for i in 1...N{
	for j in 1...i{
		if n[i - 1] > n[j - 1] {
			dp[i] = max(dp[j] + n[i - 1], dp[i])
		}
	}
}
print(dp.max()!)
