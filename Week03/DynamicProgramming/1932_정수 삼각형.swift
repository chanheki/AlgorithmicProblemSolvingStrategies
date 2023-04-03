//
//  1932_정수 삼각형.swift
//  swift_practise
//
//  Created by Chan on 2023/03/29.
//
//	https://www.acmicpc.net/problem/1932
//
//	MARK: - DP

let n = Int(readLine()!)!
var dp = Array(repeating: Array(repeating: 0, count: n), count: n)

dp[0][0] = Int(readLine()!)!

for i in 1..<n{
	let v = readLine()!.split{$0==" "}.map{Int(String($0))!}
	dp[i][0] = v[0] + dp[i-1][0]
	
	for j in 1..<v.count {
		dp[i][j] = v[j] + max(dp[i-1][j-1], dp[i-1][j])
	}
	dp[i][v.count-1] = v[v.count-1] + dp[i-1][v.count-2]
}
print(dp[n-1].max()!)
