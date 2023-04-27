/**
 * @author chanhihi
 * @email chanhihi55@gmail.com
 * @create date 2023/04/28
 * @modify date 2023/04/28
 * @desc [DP]
 */

import Foundation

let INF = 987654321
// A[]: 양자화해야할 수열 정렬한 상태
// pSum: A[]의 부분합을 저장 pSum[i]는 A[0]...A[i]의 합
// pSqSum[]: A[]제곱의 부분합을 저장. pSqSum[i]는 A[0]^2..A[i]^2의 합

var n = 10
var s = 3
var A = [3, 3, 3, 1, 2, 3, 2, 2, 2,1]
var pSum = Array(repeating: 0, count: n)
var pSqSum = Array(repeating: 0, count: n)

// A를 정렬하고 각 부분합을 계산
func precalc() {
	A.sort()
	pSum[0] = A[0]
	pSqSum[0] = A[0] * A[0]
	for i in 1..<n {
		pSum[i] = pSum[i-1] + A[i]
		pSqSum[i] = pSqSum[i-1] + A[i] * A[i]
	}
}

// A[lo]..A[hi] 구간을 하나의 숫자로 표현할 때 최소 오차 합을 계산한다.

func minError(_ lo: Int, _ hi: Int) -> Int {
	// 부분합을 이용해 A[lo]~A[hi]까지의 합을 구한다
	let sum = pSum[hi] - (lo == 0 ? 0 : pSum[lo-1])
	let sqSum = pSqSum[hi] - (lo == 0 ? 0 : pSqSum[lo-1])
	// 평균을 반올림한 값으로 이 수들을 표현한다.
	let m = Int(0.5 + Double(sum) / Double(hi - lo + 1))
	// sum(A[i]-m)^2를 전개한 결과를 부분 합으로 표현
	let ret: Int = sqSum - 2 * m * sum + m * m * (hi - lo + 1)
	return ret
}

var cache = Array(repeating: Array(repeating: -1, count: 11), count: 101)

func quantize(_ from: Int, _ parts: Int) -> Int {
	// 기저사례: 모든 숫자를 다 양자화 했을 때
	if from == n { return 0}
	// 기저사례: 숫자는 아직 남았는데 더 묶을 수 없을 때 아주 큰 값을 반환한다.
	if parts == 0 { return INF }
	var ret = cache[from][parts]
	if ret != -1 { return ret }
	ret = INF
	// 조각의 길이를 변화시켜 가며 최소치를 찾는다.
	for partSize in 1+from...n {
		ret = min(ret, minError(from, from + partSize - 1) + quantize(from + partSize, parts - 1))
	}
	return ret
}


