/**
 * @author chanhihi
 * @email chanhihi55@gmail.com
 * @create date 2023/04/27
 * @modify date 2023/04/27
 * @desc [탐욕법 Greedy]
 */

var n = 3
var e = [1, 2, 3]
var m = [1, 2, 1]

func heat() -> Int {
	var order: [(Int, Int)] = []
	
	for i in 0..<n {
		order.append((e[i], i))
	}
	order.sort() {$0.0 < $1.0}
	var ret = 0, beginEat = 0
	
	for i in 0..<n {
		let box = order[i].1
		beginEat += m[box]
		ret = max(ret, beginEat + e[box])
	}
	return ret
}

print(heat())