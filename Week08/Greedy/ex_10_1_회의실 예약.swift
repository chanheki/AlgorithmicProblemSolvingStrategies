/**
 * @author chanhihi
 * @email chanhihi55@gmail.com
 * @create date 2023/04/27
 * @modify date 2023/04/27
 * @desc [탐욕법 Greedy]
 */

// 각 회의는 [begin, end) 구간 동안 회의실을 사용

// 그림 10.1 입력
var begin = [2, 2, 1, 3, 2, 1, 5, 6, 8, 8, 9]
var end = [4, 7, 4, 5, 4, 7, 9, 9, 10, 9, 10]
var n = begin.count

func schedule() -> Int {
	// 일찍 끝나는 순서대로 정렬
	var order : [(Int, Int)] = []
	for i in 0..<n {
		order.append((end[i], begin[i]))
	}
	order.sort(by:){$0.0 < $1.0}
	
	// earliest: 다음 회의가 시작할 수 있는 가장 빠른 시간
	// selected: 지금까지 선택한 회의의 수
	var earliest = 0, selected = 0
	
	for i in 0..<order.count {
		var meetingBegin = order[i].1
		var meetingEnd = order[i].0
		
		if (earliest <= meetingBegin) {
			earliest = meetingEnd
			selected += 1
		}
	}
	return selected
}

print(schedule())