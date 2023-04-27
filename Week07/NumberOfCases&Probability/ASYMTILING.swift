/**
 * @author chanhihi
 * @email chanhihi55@gmail.com
 * @create date 2023/04/28
 * @modify date 2023/04/28
 * @desc [DP]
 */

var cache2 = Array(repeating: -1, count: 101)

func asymmetric2(width: Int) -> Int {
    if width <= 2{
        return 0
    }
    var ret = cache2[width]
    if ret != -1 { return ret }
    ret = asymmetric2(width: width - 2) % MOD
    ret = (ret + asymmetric2(width: width-4)) % MOD
    ret = (ret + tiling(width: width-3) + MOD) % MOD
    ret = (ret + tiling(width: width-3) + MOD) % MOD
    return ret
}

let MOD = 1000000007
var cache = Array(repeating: -1, count: 101)

// 2*width 크기의 사각형을 채우는 비대칭 방법의 수를 반환한다.
func asymmetric(width: Int) -> Int {
    if width % 2 == 1 {
        return (tiling(width: width) - tiling(width: width/2) + MOD) % MOD
    }
    var ret = tiling(width: width)
    ret = (ret - tiling(width: width/2) + MOD) % MOD
    ret = (ret - tiling(width: width/2-1) + MOD) % MOD
    return ret
}


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