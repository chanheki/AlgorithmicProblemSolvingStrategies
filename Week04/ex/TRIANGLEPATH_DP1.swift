/**
 * @author chanhihi
 * @email chanhihi55@gmail.com
 * @create date 2023/04/14
 * @modify date 2023/04/14
 * @desc [description]
 */
 
var r = Int(readLine()!)!

for _ in 0..<r {
	let n = Int(readLine()!)!
	var triangle = [[Int]]()
	var cache = Array(repeating: Array(repeating: Array(repeating: -1, count: n*100+1), count: n), count: n)
	var ret = -1
	
	for i in 0..<n {
		triangle.append(readLine()!.split(separator: " ").map{Int(String($0))!})
		triangle[i] += Array(repeating: 0, count: Array(triangle[i].count..<n).count)
	}
	print(path1(0, 0, 0, &ret))
	
	func path1(_ y: Int, _ x: Int, _ sum: Int, _ ret: inout Int) -> Int {
		var sum = sum
		if y == n-1 {
			return sum + triangle[y][x]
		}
		ret = cache[y][x][sum]
		if ret != -1 { return ret }
		sum += triangle[y][x]
		ret = max(path1(y+1, x+1, sum, &ret), path1(y+1, x, sum, &ret))
		return ret
	}
}
