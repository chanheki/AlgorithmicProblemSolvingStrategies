# **동적 계획법 전통 최적화 문제들**

### 개요

  동적 계획법의 가장 일반적인 사용처는 최적화 문제의 해결  
**최적화 문제란 여러 개의 가능한 답 중 가장 좋은 답(최적해)를 찾아내는 문제를 뜻한다.  
**

  최적화문제를 푸는 것 또한 완전 탐색에서 시작하지만, 특정 성질이 성립할 경우 단순 메모이제이션을 적용하기 보다 좀더 효율적으로 동적 계획법을 구현 가능.

---

## 예제: 삼각형 위의 최대 경로

  아래줄로 내려갈 때마다 바로 아래 숫자 혹은 오른쪽으로 내려갈 수 있다. 이때 모든 경로 중 숫자의 합을 최대화하는 경로는 ?  
또한 경로에 포함된 숫자들의 최대합은 ? 

![title](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2F0A1cr%2Fbtr94ysL9XD%2FNsPZnNqVdsK8Ki3tG4zlKk%2Fimg.png)

완탐으로 시작하기, pathSum(y, x, sum) 현재 위치가 (y, x)이고, 지금까지 만난 수의 합이 sum일 때, 이 경로를 맨 아래줄까지 연장해서 얻을 수 있는 최대 합을 반환

최대합을 path()를 이용해 표현하면 다음과 같은 점화식을 얻을 수 있다.

![img](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2F76QZw%2Fbtr91SezVeC%2FpHiPuczypax4ts4sgps9N1%2Fimg.png)

```
var r = Int(readLine()!)!

for _ in 0..<r {
	let n = Int(readLine()!)!
	var triangle = [[Int]]()
	var cache = Array(repeating: Array(repeating: Array(repeating: -1, count: n*100+1), count: n), count: n)
	var ret = -1
	
	for i in 0..<n {
		triangle.append(readLine()!.split(separator: " ").map{Int(String($0))!})
		triangle[i] += Array(repeating: 0, count: Array(triangle[i].count..<n).count)
	}
	print(path1(0, 0, 0, &ret))
	
	func path1(_ y: Int, _ x: Int, _ sum: Int, _ ret: inout Int) -> Int {
		var sum = sum
		if y == n-1 {
			return sum + triangle[y][x]
		}
		ret = cache[y][x][sum]
		if ret != -1 { return ret }
		sum += triangle[y][x]
		ret = max(path1(y+1, x+1, sum, &ret), path1(y+1, x, sum, &ret))
		return ret
	}
}
```

점화식을 구현한 완전 탐색에 메모이제이션을 적용한 것.  
생각보다 문제가 많은 코드 이유

-   사용해야하는 메모리가 너무 크다. 배열의 크기가 입력으로 주어지는 숫자의 범위에 좌우된다.  
      
    
-   path1()이 특정 입력에 대해서는 완탐처럼 동작한다는것. 서로 다른 경로는 합도 항상 다르다. 똑같은 (y, x)위치까지 내려왔다고 해도 경로마다 다 다른 합을 가진다. == 완전탐색

---

### 입력 걸러내기

  이 알고리즘을 더 빠르게 하는 힌트는 재귀 함수의 입력을 다름과 같이 두 부류로 나눠 보면 얻을 수 있다.

1.  y와 x는 재귀 호출이 풀어야 할 부분 문제로 지정. 두 입력이 정해지면 앞으로 우리가 만들 수 있는 경로들이 정해진다.  
    풀어야 할 조각들에 대한 정보를 주는 입력들.
2.  반면 sum은 지금까지 어떤 경로로 이 부분 문제에 도달했는지를 나타낸다.  
    sum은 지금까지 풀었던 조각들에 대한 정보를 주는 입력

![in](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FXezCD%2Fbtr92vch8hr%2FR8WsUJAdtDfkKGvKPqPark%2Fimg.png)

여기서 sum은 앞으로의 남은 조각들을 푸는 데 필요가 없다. 재귀 함수에서 sum을 쓰지 않으면 더 빨라진다.  
함수의 반환 값을 전체 경로의 최대치가 아닌 (y, x)에서 시작하는 부분 경로의 최대치로 바꿀 필요가 있다. 결과적으로는 다음과 같은 부분 문제를 얻을 수 있다.

```
path2(y, x) = (y, x)
```

![in](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbyTdgg%2Fbtr94k2rJTu%2FCQE1KaEM3WCebdwPorG6O1%2Fimg.png)

```
var r = Int(readLine()!)!

for _ in 0..<r {
	let n = Int(readLine()!)!
	var triangle = [[Int]]()
	var cache = Array(repeating: Array(repeating: -1, count: n), count: n)
	var ret = -1
	
	for i in 0..<n {
		triangle.append(readLine()!.split(separator: " ").map{Int(String($0))!})
		triangle[i] += Array(repeating: 0, count: Array(triangle[i].count..<n).count)
	}
	print(path2(0, 0, &ret))
	
	func path2(_ y: Int, _ x: Int, _ ret: inout Int) -> Int {
		if y == n-1 { return triangle[y][x] }
		ret = cache[y][x]
		if ret != -1 { return ret }
		ret = max(path2(y+1, x+1, &ret), path2(y+1, x, &ret)) + triangle[y][x]
		return ret
	}
}
```

### 이론적 배경: 최적 부분 구조

최적화 시킬 수 있었던 가장 큰 이유는 sum이라는 정보가 (y, x)에서 맨 아래줄까지 내려가는 문제를 해결하는 데 아무 상관이 없다는 사실을 파악한 덕분. 어떤 경로로 이 부분 문제에 도달했건 남은 부분 문제는 항상 최적으로 풀어도 상관 없다는 뜻. 이것은 효율적인 동적 계획법 알고리즘을 적용하기 위해 아주 중요한 조건. **최적 부분 구조(Optimal Substructure)**라는 이름을 갖고 있는 DP의 중요 요소이다.

최적 부분 구조는 어떤 문제와 분할 방식에 성립하는 조건이다. 각 부분 문제의 최적해만 있으면 전체 문제의 최적해를 쉽게 얻어낼 수 있을 경우 이 조건이 성립한다. 삼각형 문제에서는 두 개중 하나를 선택함으로써 두 개의 부분 문제로 문제를 분할할 수 있었다. 지금까지의 선택과 상관없이 각 부분 문제를 최적으로 풀기만 하면 전체 문제의 최적해도 알 수 있었다. 따라서 최적 부분 구조가 성립함을 알 수 있었다.

---