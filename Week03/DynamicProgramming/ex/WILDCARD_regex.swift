/**
 * @author chanhihi
 * @email chanhihi55@gmail.com
 * @create date 2023/04/13
 * @modify date 2023/04/13
 * @desc [ regex ]
 */

import Foundation

var r: Int = Int(readLine()!)!
var result = [String]()

for _ in 0..<r {
	solution()
}
print(result.joined(separator: "\n"))

func solution() {
	var s = readLine()!
	let n = Int(readLine()!)!
	s = "^" + s + "$"
	var mapS = s.map{String($0)}
	for i in 0..<mapS.count {
		if mapS[i] == "*" {
			mapS[i] = ".*"
		} else if mapS[i] == "?" {
			mapS[i] = "([a-zA-Z0-9])"
		}
	}
	let regex = mapS.joined()
	for _ in 0..<n {
		let ns = readLine()!
		if (ns.range(of: regex, options: .regularExpression) != nil) {
			result.append(ns)
		}
	}
}
