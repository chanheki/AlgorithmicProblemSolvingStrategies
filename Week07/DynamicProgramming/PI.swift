/**
 * @author chanhihi
 * @email chanhihi55@gmail.com
 * @create date 2023/04/28
 * @modify date 2023/04/28
 * @desc [원주율 외우기]
 */

// MARK: - 문자열처리 진짜 너무 열받는다. 나중에 다시 봐야한다.

import Foundation

let INF = 987654321

var N = "12673939"

extension String {
	subscript(_ index: Int) -> String {
		return String(self[self.index(self.startIndex, offsetBy: index)])
	}
}

extension String {
	subscript(_ range: Range<Int>) -> String {
		let fromIndex = self.index(self.startIndex, offsetBy: range.startIndex)
		let toIndex = self.index(self.startIndex,offsetBy: range.endIndex)
		return String(self[fromIndex..<toIndex])
	}
}

//N[a...b]의 구간 난이도를 반환
func classify(a: Int, b: Int) -> Int {
	// 숫자 조각을 가져온다.
	if b-a+1 <= a { return 10 }
	let M: String = N[a..<b-a+1]
	if M == "" { return 10 }
	// 첫 글자만으로 이루어진 문자열과 같으면 난이도는 1
	if M == Array(repeating: M[0], count: M.count).joined() { return 1 }
	// 등차수열인지 검사한다
	var progressive = true
	for i in 0..<M.count-1 {
		if (Int(M[i+1])! - Int(M[i])!) != (Int(M[1])! - Int(M[0])!) {
			progressive = false
		}
		// 등차수열이고 공차가 1 혹은 -1이면 난이도는 2
		if progressive == true && (abs(Int(M[1])! - Int(M[0])!) == 1) {
			return 2
		}
		// 두 수가 번갈아 등장하면
		var alternating = true
		for i in 0..<M.count {
			if M[i] != M[i%2] {
				alternating = false
			}
		}
		if alternating { return 4 }
		if progressive { return 5 }
	}
	// 둥차수열이고 공차가 1 혹은 -1이면 난이도는 2
	return 10
}

var cache = Array(repeating: -1, count: 10002)
// 수열 N[begin..]를 외우는 방법 중 난이도의 최소 합을 출력
func memorize(begin: Int) -> Int {
	// 기저사례 : 수열의 끝에 도달했을 경우
	if begin == N.count {
		return 0
	}
	// 메모이제이션
	var ret = cache[begin]
	if ret != -1 { return ret }
	ret = INF
	for L in 3...5 {
		if begin + L <= N.count {
			ret = min(ret, memorize(begin: begin + L) + classify(a: begin, b: begin + L - 1))
		}
	}
	return ret
}

print(memorize(begin: 0))
