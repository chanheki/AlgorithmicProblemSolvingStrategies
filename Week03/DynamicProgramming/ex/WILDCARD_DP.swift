/**
 * @author chanhihi
 * @email chanhihi55@gmail.com
 * @create date 2023/04/14
 * @modify date 2023/04/14
 * @desc [ DP ]
 */

import Foundation

var r: Int = Int(readLine()!)!
var result = [String]()
var cache = Array(repeating: Array(repeating: -1, count: 101), count: 101)

for _ in 0..<r {
	solution()
}
print(result.joined(separator: "\n"))

func solution() {
	let w = readLine()!
	let n = Int(readLine()!)!
	
	for _ in 0..<n {
		let s = readLine()!
		if match(w, s) {
			result.append(s)
		}
	}
}

// 와일드 카드 패턴 w가 문자열 s에 대응되는지 여부를 반환
func match(_ w: String, _ s: String) -> Bool {
	// w[pos]와 s[pos]를 맞춰나간다.
	let W = w.map{String($0)}
	let S = s.map{String($0)}

	return matchMemoized(0, 0) != 0 ? true : false
	
	// 와일드카드 패턴 W[w...]가 문자열 S[s...]에 대응되는지 여부를 반환합니다.
	func matchMemoized(_ w: Int, _ s: Int) -> Int {
		// 메모이제이션
		var ret = cache[w][s]
		if ret != -1 { return ret }
		// W[w]와 S[s]를 맞춰 나간다.
		while s < S.count && w < W.count && (W[w] == "?" || W[w] == S[s]) {
			ret = matchMemoized(w+1, s+1)
		}
		// 더이상 대응할 수 없으면 왜 while문이 끝났는지 확인.
		// 2. 패턴 끝에 도달해서 끝난경우: 문자열도 끝났어야 대응됨(참)
		if w == W.count {
			if s == S.count { ret = 1 }
			return ret
		}
		// 4. *을 만나서 끝난경우 *에 몇글자를 대응해야 할지 재귀 호출 하면서 확인한다.
		if W[w] == "*" {
//			for skip in s...S.count {
			if (matchMemoized(w+1, s) != 0) || (s < S.count && (matchMemoized(w+1, s) != 0)) {
					ret = 1
					return ret
				}
//			}
		}
		// 3. 이 외의 경우에는 모두 대응되지 않는다.
		ret = 0
		return ret
	}
}
