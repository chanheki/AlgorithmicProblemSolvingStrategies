/**
 * @author chanhihi
 * @email chanhihi55@gmail.com
 * @create date 2023/04/13
 * @modify date 2023/04/13
 * @desc [ bruteforce ]
 */

import Foundation

var r: Int = Int(readLine()!)!
var result = [String]()

for _ in 0..<r {
	solution()
}
print(result.joined(separator: "\n"))

func solution() {
	var w = readLine()!
	let n = Int(readLine()!)!
	
	for _ in 0..<n {
		let s = readLine()!
		if match(w, s) {
			result.append(s)
		}
	}
}

// 와일드 카드 패턴 w가 문자열 s에 대응되는지 여부를 반환
func match(_ W: String, _ S: String) -> Bool {
	// w[pos]와 s[pos]를 맞춰나간다.
	let w = W.map{String($0)}
	let s = S.map{String($0)}
	var pos = 0
	while pos < s.count && pos < w.count && (w[pos] == "?" || s[pos] == w[pos]) {
		pos += 1
	}
	// 더이상 대응할 수 없으면 왜 while문이 끝났는지 확인한다.
	// 2. 패턴 끝에 도달해서 끝난경우: 문자열도 끝났어야 대응됨
	if pos == w.count { return pos == s.count }
	// 4. *을 만나서 끝난 경우: *에 몇 글자를 대응해야 할지 재귀 호출하면서 확인한다.
	if w[pos] == "*" {
		for skip in pos...s.count {
			if match((w[pos+1..<w.count]).joined(), (s[skip..<s.count]).joined()) {
				return true
			}
		}
	}
	return false
}
