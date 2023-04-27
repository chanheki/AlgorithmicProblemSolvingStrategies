/**
 * @author chanhihi
 * @email chanhihi55@gmail.com
 * @create date 2023/04/28
 * @modify date 2023/04/28
 * @desc [DP / Brute force]
 */

let MOD = 10 * 1000 * 1000

var cache: [[Int]] = Array(repeating: Array(repeating: -1, count: 101), count: 101)

// n개의 정사각형으로 이루어졌고, 맨 위 가로줄에 first개의 정사각형을 포함하는 폴리오미노의 수를 반환한다.

func poly(_ n: Int, _ first: Int) -> Int {
    // 기저 사례: n == first
    if n == first { return 1 }
    // 메모이제이션
    var ret = cache[n][first]
    if ret != -1 { return ret }
    ret = 0
    for second in 1...n-first {
        var add = second + first - 1
        add *= poly(n - first, second)
        add %= MOD
        ret += add
        ret %= MOD
    }
    return ret
}