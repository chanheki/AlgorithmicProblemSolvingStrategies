/**
 * @author chanhihi
 * @email chanhihi55@gmail.com
 * @create date 2023/04/13
 * @modify date 2023/04/13
 * @desc [DynamicProgramming: 외발뛰기]
 */

var re: Int = Int(readLine()!)!

for _ in 0..<re {
	solution()
}

func solution() {
	var n: Int = Int(readLine()!)!
	var board: [[Int]] = Array<Array<Int>>()
	var cache: [[Bool]] = Array(repeating: Array(repeating: false, count: 100), count: 100) 
	for _ in 0..<n {
		board.append(readLine()!.split{$0==" "}.map{Int(String($0))!})
	}
	print(jump2(0, 0, n, board, &cache))
	print(cache[n-1][n-1] ? "YES" : "NO")
}

func jump2(_ y: Int, _ x: Int,_ n: Int, _ board: [[Int]], _ cache: inout [[Bool]]) -> Bool {
	var ret: Bool
	var jumpsize: Int
	// 기저 사례 처리
	if y >= n || x >= n { return false }
	if y == n-1 && x == n-1 {
		cache[y][x] = true
		return true 
		}
	ret = cache[y][x]
	if ret != false { return ret }
	jumpsize = board[y][x]
	ret = jump2(y + jumpsize, x, n, board, &cache) || jump2(y, x + jumpsize, n, board, &cache)
	return ret
}