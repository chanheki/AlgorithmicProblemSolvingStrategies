import Foundation

func solveSimulation(recipe: [Int], put: [Int]) -> [Int] {
    var put = put
    let n = recipe.count
    var ret = [Int](repeating: 0, count: n)
    // 각 재료를 최소한 recipe에 적힌 만큼은 넣어야 한다.
    for i in 0..<n {
        ret[i] = max(recipe[i] - put[i], 0)
        put[i] += ret[i]
    }
    // 비율이 전부 맞을 때까지 재료를 계속 추가하자.
    var iter = 0
    while true {
        iter += 1
        // 냄비에 재료를 더 넣지 않아도 될 때까지 반복한다.
        var ok = true
        for i in 0..<n {
            for j in 0..<n {
                // i 번째 재료에 의하면 모든 재료는 put[i] / recipe[i] = X배 이상은 넣어야 한다.
                // 따라서 put[j]는 recipe[j] * X 이상의 정수가 되어야 한다.
                let required = (put[i] * recipe[j] + recipe[i] - 1) / recipe[i]
                // 더 넣어야 하는가?
                if required > put[j] {
                    ret[j] += required - put[j]
                    put[j] = required
                    ok = false
                }
            }
        }
        if ok {
            break
        }
    }
    return ret
}

// MARK - 최적화된 POTION

import Foundation

func gcd(_ a: Int, _ b: Int) -> Int {
    // 최대공약수를 찾기 위한 유클리드 호제법
    return b == 0 ? a : gcd(b, a % b)
}

func ceil(_ a: Int, _ b: Int) -> Int {
    // 분수 a/b보다 같거나 큰 최소의 자연수를 반환한다.
    return (a + b - 1) / b
}

func solve(recipe: [Int], put: [Int]) -> [Int] {
    let n = recipe.count
    // 모든 recipe[i]의 최대공약수를 구한다.
    var b = recipe[0]
    for i in 1..<n {
        b = gcd(b, recipe[i])
    }
    // 최소한 b/b=1배는 만들어야 하므로, a의 초기값을 b로 둔다.
    var a = b
    // X를 직접 구하는 대신 ceil(put[i] * b, recipe[i])의 최대값을 구한다.
    for i in 0..<n {
        a = max(a, ceil(put[i] * b, recipe[i]))
    }
    // a/b배 분량을 만들면 된다.
    var ret = [Int](repeating: 0, count: n)
    for i in 0..<n {
        ret[i] = recipe[i] * a / b - put[i]
    }
    return ret
}
