//
//  9251_LCS.swift
//  swift_practise
//
//  Created by Chan on 2023/03/29.
//
//	https://www.acmicpc.net/problem/9251
//
//	MARK: - DP


/*
 *
 */

let x = readLine()!.map{String($0)}, y = readLine()!.map{String($0)}
let xC = x.count, yC = y.count
var dp = Array(repeating: Array(repeating: 0, count: yC + 1), count: xC + 1)
for i in 1...xC{
	for j in 1...yC{
		if x[i - 1] == y[j - 1] { dp[i][j] = dp[i - 1][j - 1] + 1 }
		else{ dp[i][j] = max(dp[i - 1][j], dp[i][j - 1]) }
	}
}
print(dp[xC][yC])
