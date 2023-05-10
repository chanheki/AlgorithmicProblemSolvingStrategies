// ARCTIC

var n: Int
// 두 기지 사이의 거리를 미리 계산해 둔다.
var dist = Array(repeating: Array(repeating: Double, count: 101), count: 101)
// 거리 d 이하인 기지들만을 연결했을 때 모든 기지가 연결되는지 여부를 반환한다.

func decision(_ d: Double) -> Bool {
    var visited = Array(repeating: false, count: n)
    visited[0] = true
    var q = [Int]()
    q.append(contentsOf: 0)
    var seen = 0

    while !q.isEmpty {
        var here = q.first
        q.popLast()
        seen += 1
        for there in 0..<n {
            if !visited[there] && dist[here][there] <= d {
                visited[there] = true
                q.append(contentsOf: there)
            }
        }
    }
    return seen == n
}

// 모든 기지를 연결할 수 있는 최소의 d를 반환한다.
func optimize() -> Double {
    var lo = 0.0
    var hi = 0.0
    for it in 0..<100 {
        let mid = (lo + hi) / 2
        // mid가 가능하다면, 더 좋은(작은) 답을 찾는다.
        if decision(mid) {
            hi = mid
        // mid가 불가능하다면, 더 나쁜(큰) 답을 찾는다.
        } else {
            lo = mid
        }
    }
    return hi
}