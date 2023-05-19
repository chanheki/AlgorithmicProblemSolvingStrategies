import Foundation

func isPrime(_ n: Int) -> Bool {
    // 예외 처리: 1과 2는 예외로 처리한다.
    if n <= 1 {
        return false
    }
    if n == 2 {
        return true
    }
    // 2를 제외한 모든 짝수는 소수가 아니다.
    if n % 2 == 0 {
        return false
    }
    // 2를 제외했으니 3 이상의 모든 홀수로 나누어보자.
    let sqrtn = Int(sqrt(Double(n)))
    for div in stride(from: 3, through: sqrtn, by: 2) {
        if n % div == 0 {
            return false
        }
    }
    return true
}