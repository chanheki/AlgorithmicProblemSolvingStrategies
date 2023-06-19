# 부분 합

## 도입

N명의 시험 성적을 내림차순으로 정렬해 둔 배열 S가 있다고 하자. 이때, a등에서 b등까지의 평균 점수를 계산하는 함수 average(a, b)를 구현하고 싶다고 하자. 이때, average(a, b)는 S[a]부터 S[b]까지의 합을 (b - a + 1)로 나눈 값이다.

이렇게 하면 반복문의 수행 횟수가 O(N)이 된다. 이를 개선하려면 어떻게 해야 할까?

다음 표는 한 예시이다.

| i    | 0   | 1   | 2   | 3   | 4   | 5   |
| ---- | --- | --- | --- | --- | --- | --- |
| S[i] | 100 | 98  | 95  | 90  | 80  | 70  |
| psum | 100 | 198 | 293 | 383 | 463 | 533 |

psum을 미리 계산해 두면 S[]의 특정 구간의 합을 O(1)에 계산할 수 있다.

특정 구간 합은 다음과 같이 얻을 수 있다.

```Swift
psum[s] = psum[b] - psum[a-1]
```

```Swift
func average(_ a: Int, _ b: Int) -> Double {
    return Double(psum[b] - psum[a-1]) / Double(b - a + 1)
}
```

예를 들어, S[2]부터 S[4]까지의 합은 psum[4] - psum[1]이다.

## 부분 합 계산하기

구간 합을 빠르게 계산하기 위해서는 미리 배열의 각 위치까지의 합을 계산해 두어야 한다. 이를 부분 합(partial sum)이라고 한다.

```Swift
let s = [100, 98, 95, 90, 80, 70]
let n = s.count
var psum = [Int](repeating: 0, count: n)

psum[0] = s[0]
for i in 1..<n {
    psum[i] = psum[i-1] + s[i]
}

func rangeSum(_ a: Int, _ b: Int) -> Int {
    return psum[b] - (a == 0 ? 0 : psum[a-1])
}


```

## 부분 합으로 분산 계산하기

분산(variance)은 데이터가 얼마나 퍼져 있는지를 나타내는 값이다. 분산을 계산하는 공식은 다음과 같다.

```Swift
func variance(_ a: Int, _ b: Int) -> Double {
    let mean = average(a, b)
    var ret: Double = 0
    for i in a...b {
        ret += Double(s[i] - mean) * Double(s[i] - mean)
    }
    return ret / Double(b - a + 1)
}
```

## 2차원으로 확장하기

2차원 배열의 부분 합을 계산하는 방법은 1차원 배열의 부분 합을 계산하는 방법과 거의 같다.

```Swift
let s = [[100, 98, 95, 90, 80, 70],
         [90, 95, 100, 80, 90, 100],
         [80, 90, 95, 100, 90, 95],
         [90, 80, 100, 90, 95, 85],
         [100, 100, 100, 100, 100, 100],
         [70, 80, 90, 100, 90, 95]]
let n = s.count
let m = s[0].count
var psum = [[Int]](repeating: [Int](repeating: 0, count: m), count: n)

psum[0][0] = s[0][0]
for i in 1..<n {
    psum[i][0] = psum[i-1][0] + s[i][0]
}
for j in 1..<m {
    psum[0][j] = psum[0][j-1] + s[0][j]
}

for i in 1..<n {
    for j in 1..<m {
        psum[i][j] = psum[i-1][j] + psum[i][j-1] - psum[i-1][j-1] + s[i][j]
    }
}

func gridSum(_ y1: Int, _ x1: Int, _ y2: Int, _ x2: Int) -> Int {
    var ret = psum[y2][x2]
    if y1 > 0 {
        ret -= psum[y1-1][x2]
    }
    if x1 > 0 {
        ret -= psum[y2][x1-1]
    }
    if y1 > 0 && x1 > 0 {
        ret += psum[y1-1][x1-1]
    }
    return ret
}
```

### 예제: 합이 0에 가장 가까운 구간의 합

양수와 음수가 모두 포함된 배열 A[]가 있을 때, 그 합이 0에 가장 가까운 구간의 합을 찾는 문제를 풀어보자.

| i    | 0   | 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8   | 9   |
| ---- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| A[i] | -14 | 7   | 2   | 3   | -8  | 4   | -6  | 8   | 9   | 11  |

A[]에는 합이 0인 구간이 없지만, 0에 가장 가까운 구간은 A[2] ~ A[5]로 합이 1이다. 이 문제를 해결하는 알고리즘은 다음과 같다.

1. 배열 A[]의 부분 합 배열 psum[]을 계산한다.
2. psum[]을 정렬한다.
3. 인접한 원소의 차이가 가장 작은 쌍을 찾는다.

```Swift
let A = [-14, 7, 2, 3, -8, 4, -6, 8, 9, 11]
let n = A.count
var psum = [Int](repeating: 0, count: n)

psum[0] = A[0]
for i in 1..<n {
    psum[i] = psum[i-1] + A[i]
}

psum.sort()

var ret = Int.max
for i in 1..<n {
    ret = min(ret, psum[i] - psum[i-1])
}
```
