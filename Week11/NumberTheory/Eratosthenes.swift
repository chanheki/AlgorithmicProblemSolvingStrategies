import Foundation

func sieveOfEratosthenes(upTo n: Int) -> [Int] {
    var primes = [Bool](repeating: true, count: n+1)
    var result = [Int]()
    
    primes[0] = false
    primes[1] = false
    
    let sqrtn = Int(sqrt(Double(n)))
    
    for i in 2...sqrtn {
        if primes[i] {
            // i의 배수 j들에 대해 primes[j] = false로 둔다.
            // i*i 미만의 배수는 이미 지워졌으므로 신경 쓰지 않는다.
            for j in stride(from: i*i, to: n+1, by: i) {
                primes[j] = false
            }
        }
    }
    
    for i in 2...n {
        if primes[i] {
            result.append(i)
        }
    }
    
    return result
}
