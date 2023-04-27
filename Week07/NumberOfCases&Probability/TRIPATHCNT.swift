/**
 * @author chanhihi
 * @email chanhihi55@gmail.com
 * @create date 2023/04/28
 * @modify date 2023/04/28
 * @desc [DP]
 */

var cache = Array(repeating: Array(repeating: -1, count: n), count: n)
var countCache = Array(repeating: Array(repeating: -1, count: n), count: n)
// (y, x)에서 시작해서 맨 아래줄까지 내려가는 경로 중 최대 경로의 개수를 반환한다.

func count(_ y: Int, _ x: Int) -> Int {
    // 기저 사례: 맨 아래줄에 도달한 경우
    if y == n-1 { return 1 }
    // 메모이제이션
    var ret = countCache[y][x]
    if ret != -1 { return ret }
    ret = 0
    if (path2(y+1, x+1, ret: &Int) >= path2(y+1, x)) {ret += count(y+1, x+1)}
    if (path2(y+1, x+1, ret: &Int) <= path2(y+1, x)) {ret += count(y+1, x)}
    return ret
}

func path2(_ y: Int, _ x: Int) -> Int {
    if y == n-1 { return triangle[y][x] }
    var ret = cache[y][x]
    if ret != -1 { return ret }
    ret = max(path2(y+1, x+1, &ret), path2(y+1, x, &ret)) + triangle[y][x]
    return ret
}