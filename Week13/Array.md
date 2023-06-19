# 배열

## [출처 링크](https://github.com/applebuddy/AlgorithmMemo#Swift_%EC%9E%90%EB%A3%8C%EA%B5%AC%EC%A1%B0)

<br>

배열의 초기화

```swift
let arr: [Int] = []
let arr2 = [String]()
let arr3: Array<Float> = Array()
```

<br>

- 배열 인덱스, **Array.Index의 접근(읽기) 복잡도 : O(1)**
  - **String.Index의 접근 복잡도는 O(N)**
    - 그러므로 String 접근 시 효율성이 필요하다면 배열로 변환 (Map 등) 후 접근할 필요가 있다.

<br>

배열 사용 예제

```swift
func sherlockAndAnagrams(s: String) -> Int {

    // 아래처럼 문자열 s를 배열화 시켜서 다룰 수 있다.
    let arr = Array(s)

    var Anagram = 0
    for length in 0 ... arr.count - 2 {
        var dic = [String: Int]()
        for j in 0 ..< arr.count - length {

	// 스위프트에서는 배열접근 시 아래와 같이 범위(...)를 지정해서 요소들을 접근할 수 있다.
        for j in 0 ..< arr.count - length {
            let txt = String(arr[j ... j + length].sorted())
            dic[txt] = (dic[txt] ?? 0) + 1
        }

        for k in dic {
            Anagram += (k.value * (k.value - 1) / 2)
        }
    }
    return Anagram
}
```

<br>

### 초기화 방법

- Array<타입>(repeating:<반복값>,count:<할당크기>)

<br>

배열 초기화

```swift
// chk: [Bool] 배열에 n+1의 크기만큼 true값을 적용한다.
var chk = [Bool](repeating: true, count: n+1)
```

<br>

### ✱ Array 기능

- count
  - 배열의 크기를 반환한다.
- min() -> Int?
  - 요소 내 최솟값을 반환한다.
- min() -> Int?
  - 요소 내 최댓값을 반환한다.
- first?
  - 배열의 맨 앞 요소를 반환한다.
- last?
  - 배열의 맨 마지막 요소를 반환한다.
- sorted(), filter(), map(), reduce() 등 고차함수 사용 가능(고차함수 탭 참고)
- append(<값>), append(contentsOf: <범위값>)
  - 배열의 맨 뒤에 요소를 추가한다.
- isEmpty -> Bool
  - 배열 요소가 비어있는지 확인 후 Bool값을 반환한다.

```swift
func appnd() {
    var arr = [Int]()
    arr.append(3) // arr 뒤에 3을 추가한다. -> [3]
    arr.append(2) // arr 뒤에 2을 추가한다. -> [3,2]
    print(arr) // -> [3,2]

    var arr = [1,2,3,4,5,6]
    print("nowArray elements : \(arr)") // -> [1,2,3,4,5,6]
    arr.removeSubrange(0...1) // 0 ~ 1번째 인덱스의 값을 삭제
    print("arr.removeSubrange(0...1) : \(arr)") // -> [3,4,5,6]

    arr.append(contentsOf: arr[0...1]) // 현재 arr의 0 ~ 1번째 인덱스 영역의 값을 arr 뒤에 추가한다.
    print("arr.append(contentsOf: arr[0...1]) : \(arr)") // -> [3,4,5,6,3,4]
}
```

<br>

- insert(\_ newElement: Element, at i: Int)
  - 특정 인덱스에 값을 추가한다.
    - (at: <값>)

```swift
func insertion() {
    var arr = [1,2,3]
    print("nowArray elements : \(arr)") // -> [1,2,3]

    arr.insert(99, at: 0) // 맨 앞에 99를 추가한다.
    print("arr.insert(99, at: 0) : \(arr)") // -> [99, 1, 2, 3]

    arr.insert(99, at: arr.endIndex) // 맨 뒤에 99를 추가한다.
    print("arr.insert(99, at: arr.count) : \(arr)") // -> [99, 1, 2, 3, 99]
}
```

<br>
  
- remove(at:<인덱스>)
  - <인덱스>번째의 요소를 제거한다. 
~~~ swift 
func rm() {
    var arr = [1,2,3,4,5,6]
    print("nowArray elements : \(arr)")
    
    arr.remove(at: 0)
    print("arr.remove(at: 0) : \(arr)") // => [2,3,4,5,6]
    
    arr.remove(at: arr.count-1)
    print("arr.remove(at: arr.count-1) : \(arr)") // => [2,3,4,5]
}
~~~

<br>

- removeLast()
  - 마지막 요소를 삭제한다.

```swift
func rmLast() {
    var arr = [1,2,3,4,5,6]
    print("nowArray elements : \(arr)")

    arr.removeLast()
    print("arr.removeLast() : \(arr)") // => [1,2,3,4,5]
}
```

<br>

- removeFirst()
  - 맨 앞의 요소를 삭제한다.

```swift
func rmFirst() {
    var arr = [1,2,3,4,5,6]
    print("nowArray elements : \(arr)")

    arr.removeFirst()
    print("arr.removeFirst() : \(arr)") // => [2,3,4,5,6]
}
```

<br>

- removeAll()
  - 배열 내 모든 요소를 제거하여 빈 배열로 만든다.

```swift
func rmAll() {
    var arr = [1,2,3,4,5,6]
    print("nowArray elements : \(arr)")

    arr.removeAll()
    print("removeAll() : \(arr)") // []
}
```

<br>

- removeSubrange
  - 특정 범위 인덱스의 값들을 제거한다.

```swift
func rmSubrange() {
    var arr = [1,2,3,4,5,6]

    arr.removeSubrange(0...1) // 0 ~ 1번째 인덱스의 값을 삭제
    print("arr.removeSubrange(0...1) : \(arr)") // [3,4,5,6]
}
```

<br>

- firstIndex(of:<값>) -> Int?
  - 배열 맨 앞에 나오는 <값>의 정수형 인덱스를 반환한다.
- firstIndex(of:<값>) -> Int?
  - 배열 맨 마지막에 나오는 <값>의 정수형 인덱스를 반환한다.

<br>

- swapAt(<인덱스1>,<인덱스2>)
  - 두개의 요소를 교환한다.

```swift
// swapAt() 사용 예시)
// j, j+1 인덱스의 요소를 교환한다.
arr.swapAt(j, j+1)
```

<br>

- elementsEqual()
  - 요소를 비교한 결과를 반환한다.
