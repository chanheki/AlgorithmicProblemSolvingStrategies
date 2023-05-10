// WITHDRAWAL

var n: Int
var k: Int

var c = [Int]()
var r = [Int]()

// 결정 문제: 누적 등수 average가 되도록 할 수 있나?
func decision(_ average: Double) {
    // sum(c[i]/r[i]) <= x
    // sum(c[i])/sum(r[i]) <= x
    // sum(c[i]) <= x*sum(r[i])
    // 0 <= x*sum(r[i]) - sum(c[i])
    // 0 <= sum(x*r[i]-c[i])
    // v[i] = x*r[i]-c[i]를 계산한다.

    var v = [Double]()
    for i in 0..<n {
        v.append(average * c[i] - r[i])
    }
    v.sort()
    // 이 문제는 v 중 k개의 합이 o 이상이 될 수 있는지로 바뀐다. 탐욕법으로 해결
    var sum = 0.0;
    for i in n-k..<n{
        sum += v[i];
    }
    return sum >= 0
}
// 최적화 문제: 얻을 수 있는 최소의 누적 등수를 계산한다.
func optimize() -> Int {
    // 누적 등수는 [0, 1] 범위의 실수다.
    // 반복 불변식: !decision(lo) && decision(hi)
    var lo = -1e-9
    var hi = 1


    for iter in 0..<100 {
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
