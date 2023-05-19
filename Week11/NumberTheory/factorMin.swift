import Foundation

let MAX_N = 1000000
var minFactor = [Int](repeating: 0, count: MAX_N)

func eratosthenes2(n: Int) {
    // 1은 항상 예외 처리
    minFactor[0] = -1
    minFactor[1] = -1
    
    for i in 2...n {
        minFactor[i] = i
    }
    
    let sqrtn = Int(sqrt(Double(n)))
    for i in 2...sqrtn {
        if minFactor[i] == i {
            for j in stride(from: i*i, through: n, by: i) {
                if minFactor[j] == j {
                    minFactor[j] = i
                }
            }
        }
    }
}

func factor(n: Int) -> [Int] {
    var result = [Int]()
    var num = n
    
    while num > 1 {
        result.append(minFactor[num])
        num /= minFactor[num]
    }
    
    return result
}