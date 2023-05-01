// 결정 문제: 정렬되어 있는 locations 중 cameras를 선택해 모든 카메라 간의 간격이
// gap 이상이 되는 방법 이 있는지를 반환한다.

func decision(location: [Double], cameras: Int, gap: Double) -> Bool {
	var limit: Double = -1
	var installed = 0
	
	for i in 0..<location.count {
		if limit <= location[i] {
			installed += 1
			// location[i] + gap 이후는 되어야 카메라를 설치할 수 있다.
			limit = location[i] + gap
		}
	}
	// 결과적으로 cameras대 이상을 설치할 수 있었으면 성공
	return installed >= cameras
}

// 최적화 문제: 정렬되어 있는 locations 중 cameras를 선택해 최소 간격을 최대화 한다.

func optimize(location: [Double], cameras: Int) -> Double {
	var lo: Double = 0
	var hi: Double = 241
	
//	반복문 불변식: decision(lo) && !decision(hi)
	for _ in 0..<100 {
		let mid = (lo + hi) / 2.0
		// 간격이 mid 이상이 되도록 할 수 있으면 답은 [mid, hi]에 있다.
		if decision(location: location, cameras: cameras, gap: mid) {
			lo = mid
		} else {
			hi = mid
		}
	}
	return lo
}
