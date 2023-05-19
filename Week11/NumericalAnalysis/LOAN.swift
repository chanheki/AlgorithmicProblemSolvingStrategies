// amount원을 연 이율 rates퍼센트로 duration월 동안 한 달에 monthlyPayment원씩 상환할 경우
// 남은 대출 잔금은 ?
func balance(amount: Double, duration: Int, rates: Double, monthlyPayment: Double) -> Double {
    var balance: Double = amount
    for _ in 0..<duration {
        // 이자가 붙는다.
        balance *= (1.0 + (rates / 12.0) / 100.0)
        // 상환액을 잔금에서 제한다.
        balance -= monthlyPayment
    }
    return balance
}

// amount원을 연 이율 rates퍼센트로 duration월 동안 상환하려면 한 달에 얼마씩 상환해야 하는가?
func payment(amount: Double, duration: Int, rates: Double) -> Double {
    // 불변 조건:
    // 1. 10원씩 갚으면 duration개월 안에 갚을 수 없다.
    // 2. hi원씩 갚으면 duration개월 안에 갚을 수 있다.
    var lo: Double = 0.0, hi: Double = amount * (1.0 + (rates / 12.0) / 100.0)
    for _ in 0..<100 {
        let mid: Double = (lo + hi) / 2.0
        if balance(amount: amount, duration: duration, rates: rates, monthlyPayment: mid) <= 0 {
            hi = mid
        } else {
            lo = mid
        }
    }
    return hi
}
