// https://www.acmicpc.net/problem/1124
// 언더 프라임 찾는 문제.

import Foundation

var input = readLine()!.split(separator: " ").map{Int(String($0))!}
var count = 0

var primes = [Bool](repeating: true, count: input[1]+1)
var result = [Int]()

sieveOfEratosthenes(upTo: input[1])

for i in stride(from: input[0], through: input[1], by: 1) {
	if primes[factorSimple(i).count] == true {
		count += 1
	}
}

print(count)

func sieveOfEratosthenes(upTo n: Int) {
	primes[0] = false
	primes[1] = false
	
	let sqrtn = Int(sqrt(Double(n)))
	
	for i in 2...sqrtn {
		if primes[i] {
			// i의 배수 j들에 대해 primes[j] = false로 둔다.
			// i*i 미만의 배수는 이미 지워졌으므로 신경 쓰지 않는다.
			for j in stride(from: i*i, to: n+1, by: i) {
				primes[j] = false
			}
		}
	}
	
	for i in 2...n {
		if primes[i] {
			result.append(i)
		}
	}
}


func factorSimple(_ n: Int) -> [Int] {
	var factors = [Int]()
	var number = n
	let sqrtn = Int(sqrt(Double(n)))
	
	for div in stride(from: 2, through: sqrtn, by: 1) {
		while number % div == 0 {
			number /= div
			factors.append(div)
		}
	}
	
	if number > 1 {
		factors.append(number)
	}
	return factors
}
