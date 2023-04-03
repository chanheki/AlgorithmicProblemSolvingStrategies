//
//  12865_평범한 배낭.swift
//  swift_practise
//
//  Created by Chan on 2023/03/29.
//
//	https://www.acmicpc.net/problem/11055
//
//	MARK: - DP

let b = readLine()!.split(separator: " ").map{Int(String($0))!}
var (n, k) = (b[0], b[1])
var dp = Array(repeating: 0, count: k + 1)
var wv = [(Int, Int)]()

for _ in 0..<n {
	let l = readLine()!.split(separator: " ").map{Int(String($0))!}
	wv.append((l[0], l[1]))
}

for i in 0..<n {
	for j in 0..<k {
		if wv[i].0 <= k-j {
			dp[k-j] = max(dp[k-j], dp[k-j-wv[i].0] + wv[i].1)
		}
	}
}

print(dp[k])
