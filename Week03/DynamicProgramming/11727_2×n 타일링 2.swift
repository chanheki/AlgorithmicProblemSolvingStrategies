//
//  11727_2×n 타일링 2.swift
//  swift_practise
//
//  Created by Chan on 2023/03/29.
//
//	https://www.acmicpc.net/problem/11727
//
//	MARK: - DP

let n = Int(readLine()!)!
var d = Array(repeating: 0, count: 1001)

d[1] = 1
d[2] = 3

for i in stride(from: 3, through: n, by: 1) {
	d[i] = (d[i - 1] + d[i - 2] + d[i - 2]) % 10007
}

print("\(d[n])")
