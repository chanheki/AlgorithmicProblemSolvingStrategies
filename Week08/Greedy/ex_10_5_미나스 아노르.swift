/**
 * @author chanhihi
 * @email chanhihi55@gmail.com
 * @create date 2023/04/28
 * @modify date 2023/04/28
 * @desc [탐욕법 Greedy / 기하 geometry]
 */

// 미나스 아노르 문제의 원들을 중심각의 구간으로 바꾸기

// math 쓰려고 사용
import Foundation

var pi: Double = 2.0 * acos(0)
let INF = 987654321

let N = Int(readLine()!)!

for _ in 0..<N{
	let n = Int(readLine()!)!
	var ranges = Array(repeating: (Double(), Double()), count: n)
	var y = [Double]()
	var x = [Double]()
	var r = [Double]()
	
	for _ in 0..<n {
		let input = readLine()!.split(separator: " ").map{Double(String($0))!}
		y.append(input[0])
		x.append(input[1])
		r.append(input[2])
	}
	
	
	convertToRange()
	let s = solveCircular()
	
	if s == INF {
		print("IMPOSSIBLE")
	} else {
		print(s)
	}
	
	func convertToRange() {
		for i in 0..<n {
			let loc: Double = fmod(2*pi + atan2(y[i], x[i]), 2*pi)
			let range: Double = 2.0 * asin(r[i] / 2.0 / 8.0)
			ranges[i] = (loc - range, loc + range)
		}
		// 각 구간을 시작 위치가 작은 것부터 오게끔 정렬
		ranges.sort(by:){$0.0 < $1.0}
	}
	
	func solveCircular() -> Int {
		var ret = INF
		ranges.sort(by:){$0.0 < $1.0}
		// 0을 덮을 구간을 선택
		
		for i in 0..<n {
			if ranges[i].0 <= 0 || ranges[i].1 >= 2*pi {
				// 이 구간이 덮는 부분을 빼고 남는 중심각의 범위는 다음과 같다.
				let begin: Double = fmod(ranges[i].1, 2*pi)
				let end: Double = fmod(ranges[i].0 + 2*pi, 2*pi)
				// [begin, end] 선분을 주어진 구간을 사용해 덮는다.
				ret = min(ret, 1 + solveLinear(begin, end))
			}
		}
		return ret
	}
	
	// [begin, end] 구간을 덮기 위해 선택할 최소한의 구간 수를 반환한다.
	// ranges는 시작 위치의 오름차순으로 정렬되어 있다고 가정
	func solveLinear(_ begin: Double, _ end: Double) -> Int {
		var begin = begin
		var used = 0, idx = 0
		// 덮지 못한 선분이 남아 있는 동안 계속
		while (begin < end) {
			//begin보다 이전에 시작하는 구간 중 가장 늦게 끝나는 구간을 찾는다
			var maxCover: Double = -1
			while (idx < n && ranges[idx].0 <= begin) {
				maxCover = max(maxCover, ranges[idx].1)
				idx += 1
			}
			//덮을 구간을 찾지 못한 경우
			if maxCover <= begin { return INF }
			// 선분의 덮인 부분을 잘라낸다
			begin = maxCover
			used += 1
		}
		return used
	}
}
