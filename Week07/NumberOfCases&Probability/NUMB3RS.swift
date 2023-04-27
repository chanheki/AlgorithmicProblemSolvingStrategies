/**
 * @author chanhihi
 * @email chanhihi55@gmail.com
 * @create date 2023/04/28
 * @modify date 2023/04/28
 * @desc [description]
 */

// 마을 수 n
// 지난 일수 d
// 교도소가 있는 마을 번호 p
// n개의 정수 행렬 A
// i번 행의 j번 숫자가 1이면 i번 마을에서 j번 마을을 잇는 산길이 있음. 0이면 길 없음
// 확률을 계산할 마을 수 T
// T개의 정수로 확률을 계산할 마을번호 Q
// 한 마을에서 다른 마을로 길이 있으면 반대 방향으로도 항상있으며, 한 마을에서 다시 그 마을로 연결되는 길은 없다고 가정해도 된다.

var n = 5
var d = 2
var p = 0

var cache: [[Double]] = Array(repeating: Array(repeating: -1, count: 101), count: 101)

// connected[i][j] = 마을 i, j가 연결되어 있나 여부
// deg[i] = 마을 i와 연결된 마을 개수

var connected = Array(repeating: Array(repeating: -1, count: 51), count: 51)
var deg = Array(repeating: 0, count: 51)

func search3(_ here: Int, _ days: Int) -> Double {
    if days == 0 { return (here == p ? 1.0 : 0.0)}
    var ret: Double = cache[here][days]
    if ret > -0.5 { return ret }
    ret = 0.0

    for there in 0..<n {
        if connected[here][there] {
            ret += search3(there, days-1) / deg[there]
        }
    }
    return ret
}