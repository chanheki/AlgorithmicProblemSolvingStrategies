import Foundation

var INF: Double = 1e200
var MAX = 30
var n: Int = 4// 도시 수
//var dist = Array(repeating: Array(repeating: Double(), count: MAX), count: MAX) // 도시간 거리를 저장하는 배열
var dist: [[Double]] = [[0, 10, 15, 20], [5, 0, 9, 10], [6, 13, 0, 12], [8, 8, 9, 0]]
var best: Double = INF// 지금 까지 찾은 최적해

// path: 지금까지 만든 경로
// visited 각 도시의 방문 여부
// currentlength 지금까지 만든 경로의 길이
// 나머지 도시들을 모두 방문하는 경로들을 만들어 보고 가능하면 최적해를 갱신한다.
var minEdge: [Double] = Array(repeating: Double(), count: MAX)

func simpleHeuristic(visited: [Bool]) -> Double {
	var ret = minEdge[0]
	for i in 0..<n {
		if !visited[i] { ret += minEdge[i]}
	}
	return ret
}

func search(path: [Int], visited: [Bool], currentLength: Double) {
	if best <= currentLength + simpleHeuristic(visited: visited) {return}
	var path = path, visited = visited
	var here = path.last!
	// 기저 사례: 모든 도시를 다 방문했을 때는 0번 도시로 돌아가고 종료한다.
	if path.count == n {
		best = min(best, currentLength + dist[here][0])
		return
	}
	// 다음 방문할 도시를 전부 시도해 본다.
	for next in 0..<n {
		if visited[next] { continue }
		path.append(next)
		visited[next] = true
		// 나머지 경로를 재귀호출로 통해 완성한다.
		search(path: path, visited: visited, currentLength: currentLength + dist[here][next])
		visited[next] = false
		_ = path.popLast()
	}
}

func solve() -> Double {
	var visited = Array(repeating: false, count: n)
	visited[0] = true
	search(path: [0], visited: visited, currentLength: 0)
	return best
}

print(solve())
