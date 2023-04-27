/**
 * @author chanhihi
 * @email chanhihi55@gmail.com
 * @create date 2023/04/28
 * @modify date 2023/04/28
 * @desc [cache]
 */

var cache = Array(repeating: -1, count: 100)
var S = [1,2,3,4,5,0,1,2,3,4,5]
var n = S.count

var maxLen = 0
for i in 0..<n{
	maxLen = max(maxLen, lis2(start: i))
}

print(maxLen)

func lis2(start: Int) -> Int {
	var ret = cache[start]
	if ret != -1 { return ret }
	// 항상 S[start]는 있기 때문에 길이는 최하 1
	ret = 0
	for next in start..<n {
		if S[start] < S[next] {
			ret = max(ret, lis2(start: next) + 1)
		}
	}
	return ret
}
