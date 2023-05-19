import Foundation

let TM = 10_000_000
var minFactor = [Int](repeating: 0, count: TM+1) // minFactor[i] = i의 가장 작은 소인수 (i가 소수인 경우 자기 자신)
var minFactorPower = [Int](repeating: 0, count: TM+1) // minFactorPower[i] = i의 소인수 분해에서 minFactor[i]의 횟수
var factors = [Int](repeating: 0, count: TM+1) // factors[i] = i의 약수의 수

func getFactorsSmart() {
    factors[1] = 1
    for n in 2...TM {
        // 소수인 경우 약수가 두 개 밖에 없다.
        if minFactor[n] == n {
            minFactorPower[n] = 1
            factors[n] = 2
        } 
        // 소수가 아닌 경우, 가장 작은 소인수로 나눈 수(m)의
        // 약수의 수를 이용해 n의 약수의 수를 찾는다.
        else {
            let p = minFactor[n]
            let m = n / p
            // m이 p로 더이상 나누어지지 않는 경우
            if p != minFactor[m] {
                minFactorPower[n] = 1
            } else {
                minFactorPower[n] = minFactorPower[m] + 1
            }
            let a = minFactorPower[n]
            factors[n] = (factors[m] / a) * (a + 1)
        }
    }
}
