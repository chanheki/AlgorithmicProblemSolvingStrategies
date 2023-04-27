/**
 * @author chanhihi
 * @email chanhihi55@gmail.com
 * @create date 2023/04/28
 * @modify date 2023/04/28
 * @desc [DP]
 */

let MOD = 1000000007
var cache = Array(repeating: -1, count: 101)

// 2*width 크기의 사각형을 채우는 방법의 수를 MOD로 나눈 나머지를 반환한다.

func tiling(width: Int) -> Int {
    // 기저 사례: width가 1이하 일때
    if width <= 1 {
        return 1
    }
    // 메모이제이션
    var ret = cache[width]
    if ret != -1 { return ret }
    ret = (tiling(width: width-2) + tiling(width: width-1)) % MOD
    return ret
}