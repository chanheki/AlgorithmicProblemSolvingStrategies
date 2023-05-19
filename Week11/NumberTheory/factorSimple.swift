import Foundation

func factorSimple(_ n: Int) -> [Int] {
    var factors = [Int]()
    var number = n
    let sqrtn = Int(sqrt(Double(n)))
    
    for div in 2...sqrtn {
        while number % div == 0 {
            number /= div
            factors.append(div)
        }
    }
    
    if number > 1 {
        factors.append(number)
    }
    return factors
}