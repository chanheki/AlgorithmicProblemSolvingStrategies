// 남은 도시의 수가 CACHED_DEPTH 이하면 동적 계획법으로 바꾼다
let CACHED_DEPTH = 5

// dp(here, visited) = cache[here][남은 도시의 수][visited]

var cache = Array(repeating: Array(repeating: -1, count: MAX), count: CACHED_DEPTH+1)

var dicDP = [Int: Double]()

// here 현재 위치
// visited: 각도시의 방문 여부
// 일 때, 나머지 도시를 모두 방문하고 시작점으로 돌아가는 최단 경로의 길이를 반환한다.
func dp(here: Int, visited: Int) -> Double {
	// 기저 사례: 더 방문할 도시가 없으면 시작점으로 돌아간다.
	if visited == (1<<n) - 1 { return dist[here][0] }
	// 메모이 제이션
	var remaining = n - visited.nonzeroBitCount
	var ret: Double = dicDP[cache[here][remaining]] ?? -1.0
	if ret > 0 {return ret}
	ret = INF
	for next in 0..<n {
		if (visited & (1<<next)) != 0 { continue }
		ret = min(ret, dp(here: next, visited: visited + (1<<next)) + dist[here][next])
	}
	return ret
}

