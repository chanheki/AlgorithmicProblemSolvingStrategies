import Foundation


// Given the coefficients of a univariate polynomial p, it returns the coefficients of the derivative
// 단일 변수다항식 p의 계수가 주어질 때, 미분한 결과 p'의 계수를 반환한다.
func differentiate(poly: [Double]) -> [Double] {}

// Solves a linear or quadratic equation
// 1차 혹은 2차 방정식을 푼다.
func solveNaive(poly: [Double]) -> [Double] {}

// Given the coefficients poly of a polynomial f(x), it returns f(x0)
// 다항식 f(x)의 계수 poly가 주어질 때, f(x0)를 반환한다.
func evaluate(poly: [Double], x0: Double) -> Double {}

// The absolute value of solutions must be less than or equal to L
// 방정식의 해의 절대 값은 L 이하여야 한다.
let L: Double = 25

// Returns the root of the equation sum(poly[i]*x^i) = 0
// 방정식 sum(poly[i]*x^i) = 0의 근을 반환한다.
func solve(poly: [Double]) -> [Double] {
    let n: Int = poly.count - 1
    // Base case: equations of second degree or less can be solved (기저 사례: 2차 이하의 방정식들은 해를 구할 수 있다.)
    if n <= 2 { return solveNaive(poly: poly) }
    
    // Differentiate the equation to get an n-1 degree equation (방정식을 미분해서 n-1차 방정식을 얻는다.)
    let derivative: [Double] = differentiate(poly: poly)
    var sols: [Double] = solve(poly: derivative)
    
    // Check each of these points of extremum for roots(이 극점들 사이를 하나하나 검사하며 근이 있나 확인한다.)
    sols.insert(-L-1, at: 0)
    sols.append(L+1)
    var ret: [Double] = []
    for i in 0..<sols.count - 1 {
        var x1: Double = sols[i], x2: Double = sols[i+1]
        var y1: Double = evaluate(poly: poly, x0: x1), y2: Double = evaluate(poly: poly, x0: x2)
        // If the signs of f(x1) and f(x2) are the same, there is no answer (f(x1)과 f(x2)의 부호가 같은 경우 답은 없다.)
        if y1 * y2 > 0 { continue }
        // Invariant (불변 조건): f(x1) <= 0 < f(x2)
        if y1 > y2 { swap(&y1, &y2); swap(&x1, &x2) }
        // Use the bisection method
        for _ in 0..<100 {
            let mx: Double = (x1 + x2) / 2
            let my: Double = evaluate(poly: poly, x0: mx)
            if y1 * my > 0 {
                y1 = my
                x1 = mx
            } else {
                y2 = my
                x2 = mx
            }
        }
        ret.append((x1 + x2) / 2)
    }
    ret.sort()
    return ret
}
