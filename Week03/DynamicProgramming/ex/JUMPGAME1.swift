/**
 * @author chanhihi
 * @email chanhihi55@gmail.com
 * @create date 2023/04/13
 * @modify date 2023/04/13
 * @desc [DynamicProgramming: 외발뛰기]
 */

var re = Int(readLine()!)!

for _ in 0..<re {
	solution()
}

func solution() {
	var n: Int = Int(readLine()!)!
	var board: [[Int]] = [[]]()
	for _ in 0..<n {
		board.append(readLine()!.split{$0==" "}.map{Int(String($0))!})
	}
	print(jump(0, 0, n, board))
}

func jump(_ y: Int, _ x: Int,_ n: Int, _ board: [[Int]]) -> Bool {
	var jumpsize: Int 
	var ret: Bool 
	// 기저 사례: 게임판 밖을 벗어난 경우
	if y >= n || x >= n { return false }
	// 기저 사례: 마지막 칸에 도착한 경우
	if y == n-1 && x == n-1 { return true }
	jumpsize = board[y][x]
	ret = jump(y + jumpsize, x, n, board) || jump(y, x + jumpsize, n, board)
	return ret
}