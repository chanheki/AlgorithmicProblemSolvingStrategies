/**
 * @author chanhihi
 * @email chanhihi55@gmail.com
 * @create date 2023/04/27
 * @modify date 2023/04/27
 * @desc [DP Optimal/ JLIS count ]
 */

// 입력이 32비트 부호 있는 정수의 모든 값을 가질 수 있으므로
// 인위적인 최소치는 64 비트여야한다.

let NEGINF = Int.min

for _ in 0..<Int(readLine()!)! {
	let input = readLine()!.split(separator: " ").map{Int(String($0))!}
	let (n, m) = (input[0], input[1])
	let A = readLine()!.split(separator: " ").map{Int(String($0))!}
	let B = readLine()!.split(separator: " ").map{Int(String($0))!}
	let cache = Array(repeating: Array(repeating: -1, count: 101), count: 101)
	
	// min(A[indexA], B[indexB]), max(A[indexA], B[indexB])로 시작하는
	// 합친 증가 부분 수열의 최대 길이를 반환한다.
	// 단 indexA == index B == -1 혹은 A[indexA] != B[indexB]라고 가정한다.
	func jlis(indexA: Int, indexB: Int) -> Int {
		// 메모이 제이션
		var ret = cache[indexA + 1][indexB + 1]
		if ret != -1 { return ret }
		ret = 0
		
		let a = (indexA == -1 ? NEGINF : A[indexA])
		let b = (indexB == -1 ? NEGINF : B[indexB])
		let maxElement = max(a, b)
		// 다음 원소를 찾는다
		for nextA in indexA+1..<n {
			if maxElement < A[nextA] { ret = max(ret, jlis(indexA: nextA, indexB: indexB) + 1)}
		}
		for nextB in indexB+1..<m {
			if maxElement < B[nextB] { ret = max(ret, jlis(indexA: indexA, indexB: nextB) + 1)}
		}
		
		return ret
	}
	
	print(jlis(indexA: -1, indexB: -1))
}

// MARK: - Swiftic / 잘못된 접근

import Foundation

var N = Int(readLine()!)!

for _ in 0..<N {
	let n = readLine()!.split(separator: " ").map{Int(String($0))!}
	let A = readLine()!.split(separator: " ").map{Int(String($0))!}
	let B = readLine()!.split(separator: " ").map{Int(String($0))!}
	print(Set(A+B).count)
}
