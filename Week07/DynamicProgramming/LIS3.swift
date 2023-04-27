/**
 * @author chanhihi
 * @email chanhihi55@gmail.com
 * @create date 2023/04/28
 * @modify date 2023/04/28
 * @desc [cache -1 ]
 */

import Foundation

var n = Int(readLine()!)!
var S = readLine()!.split(separator: " ").map{Int(String($0))!}
var cache = Array(repeating: -1, count: 101)

//S[start]에서 시작하는 증가 부분 수열 중 최대 길이를 반환한다.
func lis3(start: Int) -> Int {
	var ret = cache[start + 1]
	if ret != -1 { return ret }
	ret = 1
	for next in stride(from: start+1, to: n, by: 1) {
		if start == -1 || S[start] < S[next] {
			ret = max(ret, lis3(start: next) + 1)
		}
	}
	return ret
}

print(lis3(start: -1) - 1)
