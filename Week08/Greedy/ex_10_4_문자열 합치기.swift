
//문자열들의 길이가 주어질 때 하나로 합치는 최소 비용을 반환한다.
func concat(lengths: [Int]) -> Int {
	var pq = [Int]()
	for i in 0..<lengths.count {
		pq.append(lengths[i])
	}
	var ret = 0
	while (pq.count > 1) {
		pq.sort(by: >) // 큐로 써야한다.
		//가장 짧은 문자열 두 개를 찾아서 합치고 큐에 넣는다.
		let min1 = pq.popLast()!
		let min2 = pq.popLast()!
		print(min1, min2)
		pq.append(min1 + min2)
		ret += (min1 + min2)
	}
	
	return ret
}

print(concat(lengths: [3, 1, 1, 3, 4]))
