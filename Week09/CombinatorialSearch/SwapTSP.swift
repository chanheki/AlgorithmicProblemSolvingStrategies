
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
var nearest: [[Int]] = Array(repeating: [Int](), count: MAX)

// path의 마지막 네개의 도시 중 가운데 있는 두 도시의 순서를 바꿨을 때 경로가 더 짧아지는지 여부를 반환
func pathSwapPruning(path: [Int]) -> Bool {
	if path.count < 4 { return false }
	var p = path[path.count - 4]
	var a = path[path.count - 3]
	var b = path[path.count - 2]
	var q = path[path.count - 1]
	return dist[p][a] + dist[b][q] > dist[p][b] + dist[a][q]
}

// 시작 도시와 현재 도시를 제외한 path의 부분 경로를 뒤집어 보고 더 짧아지는지 확인

func pathReversePruning(path: [Int]) -> Bool {
	if path.count < 4 { return false }
	var b = path[path.count - 2]
	var q = path[path.count - 1]
	for i in 0..<path.count-3 {
		var p = path[i]
		var a = path[i + 1]
		// [...,p,a,...,b,q]를 [...,p,b,...,a,q]로 바꿔본다
		if dist[p][a] + dist[b][q] > dist[p][b] + dist[a][q] {
			return true
		}
	}
	return false
}

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
	let here = path.last!
	// 기저 사례: 모든 도시를 다 방문했을 때는 0번 도시로 돌아가고 종료한다.
	if path.count == n {
		best = min(best, currentLength + dist[here][0])
		return
	}
	print(nearest)
	// 다음 방문할 도시를 전부 시도해 본다.
	for i in 0..<nearest[here].count {
		var next = nearest[here][i]
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
//	nearest 초기화
	for i in 0..<n {
		var order: [(Double, Int)] = [(Double, Int)]()
		for j in 0..<n {
			if i != j {order.append((dist[i][j], j))}
		}
		order.sort(by:){$0.0 < $1.0}
		for j in 0..<n-1{
			nearest[i].append(order[j].1)
		}
	}
	var visited = Array(repeating: false, count: n)
	visited[0] = true
	search(path: [0], visited: visited, currentLength: 0)
	return best
}

print(solve())