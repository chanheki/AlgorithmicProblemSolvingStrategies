# 비트마스크(Bitmask)

현대의 모든 CPU는 이진수를 이용해 모든 자료를 표현한다. 

정수의 이진 표현을 자료 구조로 쓰는 기법을 비트마스크라고 한다. 비트마스크는 엄밀하게 말해 자료구조라고는 할 수 없지만, 굉장히 유용하게 사용된다. 

### 장점
- **더 빠른 수행 시간**: 비트마스크 연산은 O(1)에 구현되는 것이 많기 때문에, 적절히 사용할 경우 다른 자료 구조를 사용하는 것보다 훨씬 빠르게 동작한다.
- **더 간결한 코드**: 다양한 집합 연산들을 반복문 없이 한 줄에 쓸 수 있기 때문에 비트마스크를 적절히 사용하면 굉장히 짧은 코드를 작성할 수 있다. 
- **더 작은 메모리 사용량**: 비트마스크를 이용하는 코드들은 같은 데이터를 더 적은 메모리를 사용해 표현할 수 있다. 더 적은 메모리를 사용한다는 말은 더 많은 데이터를 미리 계산해서 저장해 둘 수 있다는 뜻. 더 많은 데이터를 미리 계산해 둘수 있으면 프로그램도 빨라지고, 더 적은 메모리를 사용하는 프로그램은 일반적으로 캐시 효율도 더 좋다.
- **연관 배열을 배열로 대체**: c++에서 불린 값 배열을 키로 갖는 연관 배열 객체 map <vector<bool>, int>를 사용하고 있다고 할때. 이때 비트마스크를 써서 같 은 정보를 정수 변수로 나타내면 단순한 배열 int[]를 사용해 같은 정보를 나 타낼 수 있다. 많은 경우 이 기법은 엄청난 시간과 메모리의 차이를 불러 온다.

## 용어 정의

이진수의 한 자리를 bit라고 부른다. 비트는 0 혹은 1의 값을 가질 수 있다. 컴퓨터가 표현하는 모든 자료의 근간이 된다. 부호 없는 8비트 정수형은 여덟 자리 이진수로 표시할 수 있는 모든 정수를 표현할 수 있다. 따라서 부호 없는 8비트 정수형이 가지 수 있는 최소값은 0, 최대값은 1111 1111₂ = 255

부호 없는 N비트 정수형 변수는 N자리 이진수로 쓸 수 있다. 2⁰ ~ 2ᴺ⁻¹. 이때 최상위 비트(most significant bit)는 2ᴺ⁻¹이고, 2⁰는 최하위 비트(least significant bit)가 된다. 이진수로 표현했을 때 어떤 비트의 위치가 1이면 해당 비트가 "켜져 있다"라고 하고, 0이라면 "꺼져 있다" 라고 한다.

### 비트 연산자

|연산|코드|
|---|---|
|두 정수 a, b를 비트별로 AND 연산| a & b |
|두 정수 a, b를 비트별로 OR 연산| a \| b |
|두 정수 a, b를 비트별로 XOR 연산 | a ^ b |
|정수 a의 비트별 NOT 연산 결과 | 〜a |
|정수 a를 왼쪽으로 b비트 시프트 | a << b |
|정수 시를 오른쪽으로 b비트 시프트 | a >> b |

### 유의할 점들

- 연산자 간 우선순위를 혼동하는 것. (혼동하지 않으려면 괄호를 자세하게 추가하는 습관을 들여야 한다.)
- 64비트 정수를 비트마스크로 사용할 때 발생하는 오버플로 

---

## 비트마스크를 이용한 집합의 구현

비트마스크의 가장 중요한 사용 사례는 집합을 구현하는 것. 이 표현에서 N비트 정수 변수는 0부터 N-1까지의 정수 원소를 가질 수 있는 집합이 된다. 이때 원소 i가 집합에 속해 있는지 여부는 2ⁱ을 나타내는 비트가 켜져 있는지 여부로 나타낸다. 예를 들어 여섯 개의 원소를 갖는 집합 [1, 4, 5, 6, 7, 9]을 표현하는 정수는 754임을 다음과 같이 알수 있다.

2^1+2^4+2^5+2^6+2^7+2^9 = 10 1111 0010₂=754
### 피자집 예제

고객들이 원하는 토핑을 골라 주문할 수 있는 피자집의 주문 시스템을 만든다고 할때, 이 피자집에는 0부터 19까지의 번호를 갖는 스무 가지의 토핑이 있으며, 주문시 토핑을 넣기/넣지 않기를 선택할 수 있다. 그러면 한 피자의 정보는 스무 종류의 원소만을 가지는 집합이 되고, 비트마스크를 이용해 표현 할 수 있다. 물론 크기 20인 불린 값 배열을 사용하더라도 같은 일을 할 수 있지만, 비트마스크를 이용하면 다양한 비트 연산을 이용해 집합 연산을 빠르고 간단하게 구현할 수 있다.

### 공집합과 꽉 찬 집합 구하기

토핑을 올리지 않은 치즈, 피자와 모든 토핑을 올린 ‘전부다’ 피자를 표현하려 할 때. 비트마스크를 이용하는 집합에서 공집합을 표현하는 것은 너무나도 간단하다. 상수 0이 공집합을 나타낸다. 꽉 찬 집합을 구하는 것 또한 매우 간단. 스무 개의 토핑을 모두 포함하는 집합은 마지막 20개의 비트가 모두 켜진 숫자인데, 이것을 다음과 같은 코드로 얻을 수 있다.

``` swift
var fullPizza: Int = (1 << 20) - 1

// (11111111111111111111)b
```

1<<20은 이진수로 1 뒤에 20개의 0이 있는 정수인데, 여기서 1을 빼면 20개의 비트가 모두 켜진 수를 얻을 수 있다.

### 원소 추가와 삭제

원소를 추가하는 것은 비트를 켜는 것과 같다. 예를 들어 토핑 3을 추가하려면 다음과 같은 코드를 사용한다. 하지만 만약 이미 들어가 있으면 값이 변하지 않는다는데 유의하자.

``` swift
var pizza: Int = 0
pizza |= (1 << 3)
```

원소를 삭제하는 것은 비트를 끄는 것과 같다. 예를 들어 토핑 3을 삭제하려면 다음과 같은 코드를 사용한다.

``` swift
pizza -= (1 << 3) // 이미 해당 3토핑이 목록에 있을 때만 사용할 수 있다. 만약 없는데 사용하면 원치 않는 결과가 나온다.
pizza &= ~(1 << 3) // 그래서 이 방법을 쓴다. 해당 비트만 꺼지고 나머지 비트는 유지된다.
```

### 원소의 포함 여부 확인

원소의 포함 여부를 확인하는 것은 비트를 확인하는 것과 같다. 예를 들어 토핑 3이 포함되어 있는지 확인하려면 다음과 같은 코드를 사용한다.

``` swift
if pizza & (1 << 3) != 0 {
	print("토핑 3이 포함되어 있음")
}
```

### 원소의 토글

원소의 토글은 비트를 반전하는 것과 같다. 예를 들어 토핑 3을 토글하려면 다음과 같은 코드를 사용한다.

``` swift
pizza ^= (1 << 3)
```

### 집합 연산

비트마스크를 이용해 집합 연산을 구현할 때는 비트 연산을 이용하면 된다. 예를 들어 두 집합의 합집합을 구하려면 두 정수의 비트를 더하면 된다. 두 집합의 교집합을 구하려면 두 정수의 비트를 곱하면 된다. 두 집합의 차집합을 구하려면 두 정수의 비트를 뺀다. 두 집합의 여집합을 구하려면 두 정수의 비트를 반전시킨다.

``` swift
let union: Int = pizza | pasta			// 합집합
let intersection: Int = pizza & pasta	// 교집합
let difference: Int = pizza & ~pasta	// 차집합
let complement: Int = ~pizza			// 여집합
```

### 집합의 크기 구하기

집합의 크기를 구하는 것은 비트를 세는 것과 같다. 예를 들어 토핑이 3개인 피자를 만들려면 다음과 같은 코드를 사용한다.

``` swift
var toppingCount: Int = 0
for i in 0..<20 {
	if pizza & (1 << i) != 0 {
		toppingCount += 1
	}
}

// 위의 코드를 더 간단하게 표현하면 다음과 같다. 한번만 돌거면 이거 써도 된다.
var toppingCount: Int = 0
while pizza > 0 {
	toppingCount += pizza & 1
	pizza >>= 1
}

// non-zero bit로 세는 방법
pizza.nonzeroBitCount

```

### 최소 원소 찾기

``` swift
func ctz(_ n: UInt) -> Int {
    guard n != 0 else { return Int.bitWidth }
    var x = n
    var count = 0
    while x & 1 == 0 {
        x >>= 1
        count += 1
    }
    return count
}

let number: UInt = 16
print(ctz(number)) // Output: 4

// non-zero bit의 index를 찾는 방법 UInt일 때만 가능
pizza.trailingZeroBitCount

// 2의 보수를 이용한 방법
var firstTopping = pizza & -pizza
```

### 최소 원소 제거하기

``` swift
pizza &= pizza - 1
```
pizza - 1의 이진수 표현은 켜져있는 최하위 비트를 끄고 그 밑의 비트들을 모두 켠 것.

이 방법은 어떤 정수가 2의 거듭제곱 값인지 확인할 때도 유용하다. 켜진 비트가 하나밖에 없기 때문. 최하위 비트를 지웠을때 0이 되면 주어진 수는 2의 거듭제곱.

### 모든 부분 집합 순회하기

``` swift
var subset = pizza
while subset > 0 {
    // do something
    subset = (subset - 1) & pizza
}
```

### 비트마스크를 이용한 순열 생성

``` swift
func nextPermutation(_ n: Int) -> Int {
    var x = n
    let smallest = x & -x
    let ripple = x + smallest
    let newSmallest = ripple & -ripple
    let ones = ((newSmallest / smallest) >> 1) - 1
    return ripple | ones
}

var permutation = (1 << 3) - 1
while permutation < (1 << 5) {
    // do something
    permutation = nextPermutation(permutation)
}
```

### 비트마스크를 이용한 조합 생성

``` swift
func nextCombination(_ n: Int, _ r: Int) -> Int {
    var x = (1 << r) - 1
    let end = 1 << n
    while x < end {
        // do something
        let smallest = x & -x
        let ripple = x + smallest
        let newSmallest = ripple & -ripple
        let ones = ((newSmallest / smallest) >> 1) - 1
        x = ripple | ones
    }
    return x
}

var combination = (1 << 3) - 1
while combination < (1 << 5) {
    // do something
    combination = nextCombination(5, 3)
}
```

### 비트마스크를 이용한 순열의 순서 찾기

``` swift
func nthPermutation(_ n: Int, _ k: Int) -> Int {
    var x = (1 << n) - 1
    var y = 0
    var k = k - 1
    while k > 0 {
        let smallest = x & -x
        let ripple = x + smallest
        let newSmallest = ripple & -ripple
        let ones = ((newSmallest / smallest) >> 1) - 1
        x = ripple | ones
        y += 1 << (ctz(smallest) - 1)
        k -= 1
    }
    return y
}

print(nthPermutation(5, 10)) // Output: 10111
```

### 비트마스크를 이용한 조합의 순서 찾기

``` swift
func nthCombination(_ n: Int, _ r: Int, _ k: Int) -> Int {
    var x = (1 << r) - 1
    var y = 0
    var k = k - 1
    while k > 0 {
        let smallest = x & -x
        let ripple = x + smallest
        let newSmallest = ripple & -ripple
        let ones = ((newSmallest / smallest) >> 1) - 1
        x = ripple | ones
        y += smallest
        k -= 1
    }
    return y
}

print(nthCombination(5, 3, 10)) // Output: 11010
```

