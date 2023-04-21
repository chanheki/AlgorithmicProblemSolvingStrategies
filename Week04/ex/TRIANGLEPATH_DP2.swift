/**
 * @author chanhihi
 * @email chanhihi55@gmail.com
 * @create date 2023/04/14
 * @modify date 2023/04/14
 * @desc [ DP ]
 */

var r = Int(readLine()!)!

for _ in 0..<r {
	let n = Int(readLine()!)!
	var triangle = [[Int]]()
	var cache = Array(repeating: Array(repeating: -1, count: n), count: n)
	var ret = -1
	
	for i in 0..<n {
		triangle.append(readLine()!.split(separator: " ").map{Int(String($0))!})
		triangle[i] += Array(repeating: 0, count: Array(triangle[i].count..<n).count)
	}
	print(path2(0, 0, &ret))
	
	func path2(_ y: Int, _ x: Int, _ ret: inout Int) -> Int {
		if y == n-1 { return triangle[y][x] }
		ret = cache[y][x]
		if ret != -1 { return ret }
		ret = max(path2(y+1, x+1, &ret), path2(y+1, x, &ret)) + triangle[y][x]
		return ret
	}
}
