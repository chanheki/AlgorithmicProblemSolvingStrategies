/**
 * @author chanhihi
 * @email chanhihi55@gmail.com
 * @create date 2023/04/28
 * @modify date 2023/04/28
 * @desc [DP]
 */

// n: n미터 m: 일자
var n: Int = 0, m: Int = 0
var cache: [[Int]] = Array(repeating: Array(repeating: -1, count: n), count: 2*n+1)

// 달팽이가 days일 동안 climbed미터를 기어올라왔다고 할 때 
// m일 전까지 n미터를 기어올라갈 수 있는 경우의 수

func climb(days: Int, climbed: Int) -> Int {
    // 기저 사례: m일이 모두 지난 경우
    if days == m { return climbed >= n ? 1 : 0}
    // 메모이제이션
    var ret = cache[days][climbed]
    if ret != -1 { return ret }
    ret = climb(days: days+1, climbed: clibed+1) + climb(days: days+1, climbed: climbed+2)
    return ret 
}


func climb2(days: Int, climbed: Int) -> Int {
    // 기저 사례: m일이 모두 지난 경우
    if days == m { return climbed >= n ? 1 : 0}
    // 메모이제이션
    var ret = cache[days][climbed]
    if ret != -1 { return ret }
    ret = 0.75 * climb(days: days+1, climbed: clibed+1) + 0.25 * climb(days: days+1, climbed: climbed+2)
    return ret 
}
