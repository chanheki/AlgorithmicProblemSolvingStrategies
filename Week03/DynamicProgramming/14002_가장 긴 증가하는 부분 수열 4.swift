//
//  14002_가장 긴 증가하는 부분 수열 4.swift
//  swift_practise
//
//  Created by Chan on 2023/03/29.
//
//	https://www.acmicpc.net/problem/14002
//
//	MARK: - DP

let n = Int(readLine()!)!
let A = readLine()!.split(separator: " ").map {Int(String($0))!}
var dp = [Int]()

for i in 0..<n {
	dp.append(1)
	for j in 0..<i+1 {
		if A[i] > A[j] {
			dp[i] = max(dp[i], dp[j]+1)
		}
	}
}
print(dp.max()!)

var maxDp = dp.max()!
var maxIdx = dp.firstIndex(of:maxDp)!
var answer = [Int]()

while maxIdx >= 0 {
	if dp[maxIdx] == maxDp {
		answer.append(A[maxIdx])
		maxDp -= 1
	}
	maxIdx -= 1
}

print(answer.map{String($0)}.reversed().joined(separator: " "))
