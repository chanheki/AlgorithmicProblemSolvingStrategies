# [정수론 NumberTheory]

이산 수학.

---

## 소수

소수(prime number)는 정수론의 가장 중요한 연구 대상 중 하나로, 양의 약수가 1과 자기 자신 두 개 뿐인 자연수를 의미. 소수의 반대말로, 세 개 이상의 양의 약수를 갖는 자연수를 합성수(composite number)라고 한다. 예를 들어 7은 1과 7 외에는 약수가 없기 때문에 소수입니다. 반면 9는 3으로 나누어 떨어지기 때문에 합성수. 이 정의에 따르면 1은 소수도 아니고 합성수도 아니다. 이와 같은 성질 때문에 1은 소수에 관련된 문제 들에서 가장많이 걸려 넘어지는 예외이다.

[isPrime 구현 🔗](NumberTheory/isPrime.swift)

isPrime을 최적화하는 방법은 여러가지 있다. 2와 3을 제외한 모든 소수는 6k+-1의 형태를 하고 있다는 사실을 이용할 수도있고, 작은 소수들의 목록을 미리 만들어 놨다가 이들로 먼저 나누는 방법을 시도할 수도 있다. 하지만 이와같은 최적화는 자주 쓰이지 않는다. 많은 수의 소수를 판단해야 할 때는 대개 에라토스테네스의 체를 이용하여 특정 범위의 숫자들에 대해 미리 소수 판단을 해 두는 방법을 사용하게 된다.

---

## 소인수 분해

한 합성수를 소수들의 곱으로 표현하는 방법을 찾는 소인수 분해(prime factorization) 또한 프로그래밍 대회에서 종종 볼 수 있다. 소인수 분해를 하는 가장 쉬운 방법은 앞에서 다룬 간단한 소수 판별 알고리즘을 응용하는 것. 2부터 시작해 n의 소인수가 될 수 있는 수들을 하나하나 순회하면서, n의 약수를 찾을 때마다 n을 이 숫자로 나눈다. 이 알고리즘은 n이 소수인 경우 sqrt(n)번 반복문을 돌기 때문에 시간복잡도는 O(srqt(n))이 됩니다.

아래 코드가 이의 구현을 보여줍니다. 소수인 div로만 n을 나누려 시도하는 대신 [2, sqrtn] 범위의 모든 정수로 시도한다는 것을 눈여겨 봐야한다. 하지만 만약 div가 합성수라면 이미 n은 div의 소인수들로 최대한 나눠진 뒤이기 때문에, n이 div로 나누어 떨어질 일은 없다.

[Factor Simple 구현 🔗](NumberTheory/factorSimple.swift)

소인수 분해를 최적화 할 수 있는 방법 또한 여러가지가 있는데, 한가지 방법은 처리해야 할 입력의 최대값 MAX에 대해 sqrt(MAX)까지의 소수들을 미리 찾아 두는것. 그러면 [2, sqrt(n)]범위의 모든 정수 대신 소수들로만 n을 나눠 볼 수 있기 때문에 훨씬 빨라진다.

---

## [에라토스테네스의 체(Sieve of Eratosthenes)](https://ko.wikipedia.org/wiki/%EC%97%90%EB%9D%BC%ED%86%A0%EC%8A%A4%ED%85%8C%EB%84%A4%EC%8A%A4%EC%9D%98_%EC%B2%B4)


[가장 간단한 에라토스테네스의 체 구현 🔗](NumberTheory/Eratosthenes.swift)

에라토스테네스의 체의 시간 복잡도는 계산하기 까다롭다. 내부 반복문이 얼마나 실행될지는 [1, sqrt(n)] 범위 내에 소수가 어떤 분포로 출현하는지에 따라 달라지기 때문. 소수의 분포를 근사값으로 표현하는 기법을 사용하면, 필요한 전체 연산의 수가 O(loglogn)임을 증명할 수 있다.loglogn은 굉장히 느리게 증가하는 함수이기 때문에 (64비트 정수형에 들어가는 최대 수에 대해서도 4를 넘지 않는다) 실용적인 범위 내에서 수행 시간은 거의 O(n)과 비슷하다.

이렇듯 수행 시간이 빠르기 때문에 에라토스테네스의 체를 구현할 때 문제가 되는 것은 시간보다는 메모리 사용량. 많은 수에 대해 에라토스테네스의 체를 수행해야 할 때는 짝수를 별도로 처리해서 필요한 배열의 크기를 절반으로 줄이거나, 비트마스크를 이용하는 등의 기법을 이용해 체가 사용하는 메모리의 양을 최적화할수 있다.
에라토스테네스의 체는 여러 형태로 변형할 수 있기 때문에 여러 정수론 문제를 푸는 데 가장 유용하게 사용.

---

## 에라토스테네스의 체를 이용한 빠른 소인수 분해

체에서 각 숫자가 소수인지 합성수인지만을 기록하는 것 뿐만이 아니라, 각 숫자의 가장 작은 소인수를 같이 기록해 두는 것입니다. 예를 들어 28 = 2 * 2 * 7이므로 28의 가장 작은 소인수 2를 같이 기록해두는 것.

[에라토스테네스의 체를 이용한 빠른 소인수 분해🔗](NumberTheory/factorMin.swift)

---

## 에라토스테네스의 체 응용하기

[1천만 이하의 모든 수의 약수의 수를 계산하는 알고리즘🔗](NumberTheory/factorSmart.swift)

---

## 에라토스테네스의 체와 소인수 분해를 사용한 백준 문제

소인수 분해와 에라토스테네스의 체를 응용해서 풀기 딱 좋은 문제이다.

[1124 언더프라임🔗](NumberTheory/Eratosthenes+factor.swift)

---

## 유클리드 알고리즘

유클리드 알고리즘(Euclidean algorithm)은 두 수의 최대공약수를 구하는 방법으로, 기록이 남아 있는 가장 오래된 알고리즘으로 유명. 유클리드 알고리즘은 두 수 p, q(p>q)의 공약수의 집합은 p-q와 q의 공약수 집합과 같다는 점을 이용. p, q의 최대공약수 gcd(p, q)는 항상 p-q와 q의 최대 공약수 gcd(p - q, q)와 같다. 이 성질을 이용해 6과 15의 최대공약수를 구해보자.

gcd(6, 15) = gcd(9, 6) = gcd(3, 6) = gcd(3, 3) = gcd(0, 3)

한 수가 0이 될때, 최대공약수는 다른 한수.

``` Swift
func gcd(_ p: Int, _ q: Int) -> Int {
    if p < q { swap(p, q) }
    if q == 0 { return p }
    return gcd(p-q, q)
}
```
이를 더욱 최적화 할 수 있는데 다음과 같다.
부등호 연산을 하지 않아도 다음 재귀를 탈 때 처리가 된다는 점을 눈여겨 보자.

``` Swift
func gcd(_ p: Int, _ q: Int) -> Int {
    if q == 0 { return p }
    return gcd(q, p % q)
}
```

---

## POTION

[POTIN 🔗](NumberTheory/POTION.swift)

---

## 모듈라 연산(Modular arithmetic)

모듈로(modulus) M에 도달하면 다시 0으로 돌아가는 정수들을 가지고 하는 연산.

### 모듈라 덧셈, 뺄셈, 그리고 곱셈

- (a + b) % M = ((a % M) + (b % M)) % M
- (a - b) % M = ((a % M) - (b % M)) % M
- (a * b) % M = ((a % M) * (b % M)) % M

### 모듈라 나눗셈

나눗셈은 일반적인 공식이 성립하지 않음.

모듈라 연산의 나눗셈은 a/b에서 b로 나누는 대신 b의 곱셈 역원(multiplicative inverse)를 곱하는 방식으로 이루어짐.

modInv(b, M) = b^M-2%M

(a/b)%M=(a*modInv(b,M))%M 이며,

만약 M이 소수가 아닌 경우에도 b의 역원을 찾고 싶다면 다음과 같은 식을 만족하는 A를 찾으면된다.

A*b + B*M = 1(mod M)

이와 같은 형태의 식을 디오판틴 방정식(Diophantine equation)이라고 부르는데, 유클리드 알고리즘의 변형인 확장 유클리드 알고리즘으로 풀 수 있다.

---

## 더 읽을거리

- 확장 유클리드 알고리즘
- 중국인의 나머지 정리
- 루카스의 정리