# 최적화 문제 결정

## 도입

### Decision Problem

딱히 이름이 붙어 있지 않지만 굉장히 유용한 디자인 원칙 중 하나로, 최적화 문제를 결정 문제（decision problem）로 바꾼 뒤, 이것을 이분법을 이용해 해결하는 방법이 존재

결정 문제란 예 혹은 아니오 형태의 답만이 나오는문제들을 가리키며. 최적화문제의 반환 값은 대개 실수나 정수이므로 답의 경우의 수가 무한한 데 반해, 결정 문제는 두 가지 답만이 있을 수 있다.

다음은 여행하는 외판원 문제를 최적화 문제와 결정 문제로 표현한 것입니다.

```
optimize(G) = 그래프 G의 모든 정점을 한 번씩 방문하고 시작점으로 돌아오는 최단 경로의 길이를 반환한다. （최적화문제）

decision(G, x) = 그래프 G의 모든 정점을 한 번씩 방문하고 시작점으로 돌아오면서 길이가 x 이하인 경로의 존재 여부를 반환한다. （결정 문제）
```

optimize()는 가장 짧은 경로의 길이를 실수로 반환하지만, decision()은 최단 경로건 아니건 간에 x보다 짧은 경로가 있는지만 확인하면 된다.


### 최적화 문제와 결정 문제의 관계

같은 문제를 최적화 문제 형태와 결정 문제 형태로 만들었을 때, 푸는 데 시간이
더 오래 걸리는쪽은 어느쪽일까요? 이 질문에 대한 답은둘중의 하나입니다.

- 두 문제 형태가 똑같이 어려운 경우
- 최적화문제가 더 어려운 경우

다시 말해 결정 문제가 최적화 문제보다 어려울 수는 없다는 뜻.
최적화 문제를 푸는 optimized 있으면 결정 문제는 다음과 같이 한 줄로 짤 수 있기 때문이다.

``` Swift
func optimize(g: Graph) -> Double
func decision(g: Graph, x: Double) { optimize(g) <= x}
```

## 예제 DARPA를 통한 결정문제 엿보기

[DARPA 구현 🔗](DecisionProblem/DARPA.swift)

### 이분법의 함정

이 문제에서 답이 가질 수 있는 값의 가지수는 유한하다. 이 문제의 답은 항상 입력으로 주어진 두 장소 간의 거리이기 때문에, 존재 할 수 있는 답은 (n-1) * n / 2가지 밖에 없다. 따라서 이들의 목록을 미리 만들어 두고 여기서 이분 검색을 통해 동작 속도를 올리려는 시도를 해 볼 수 있다. 그런데 이렇게 탐색의 범위가 유한해지면 이분법은 수치적 안정성을 잃어버리게 된다.

어떤 입력의 정답이 4.2라고 가정할때, 연산 중 수치적 오차가 생겨 결정 문제가 4.2에 대해 참 대신 거짓을 반환했다고 하면.  optimize()는 4.2를 상한으로 하고 4.2와 가까운 숫자들을 계속 시도 한다. 결 과적으로는 4.1999999•••가 반환되고, 수치적 오차가 생긴다고 해도 답이 크게 달라지지 않는다. 반면 고정된 수의 후보만을 탐색하는 이분법에서는 이와 같은 오류가 생길 경우 4.2 보다 작은 후보로 반환 값이 바뀌기 때문에 오차가 커 질 수 있으므로 유의해야 한다.

### 다른 해법
m개의 위치 중 n개를 선택해 카메라를 선택하는 문제를 n조각으로 쪼개, 각 조각마다 어느 위치에 카메라를 설치할지 정한다고 하자. 이것을 재귀 호출 알고리즘으로 구현하면 간단하게 메모이제이션할 수 있고, 따라서 이 문제는 사실 동적 계획법으로도 풀 수 있다.

### 최적화 문제 결정 문제로 바꾸기 레시피

1. “가장 좋은 답은 무엇인가?”라는 최적화 문제를 “x 혹은 그보다 좋은 답이 있는가?”라는 결정 문제 형태로 바꿉니다.
2. 결정 문제를 쉽게 풀 수 있는 방법이 있는지 찾아봅니다.
3. 결정 문제를 내부적으로 이용하는 이분법 알고리즘을 작성합니다.

---

## ARCTIC

연락망이 주어질 때, 무전기 통신 반경은 직접 연결된 두 기지 간의 최대 거리가 됩니다. 이렇게 생각하면 이 문제를 다음과 같이 표현할수 있습니다.

optimize(P)=P에 주어진 기지들을 모두 연결하는 연락망을 구축할 때 가능 한 최소 무전기 반경은 얼마인가?

기지들을 모두 연결하는 연락망은 여 러 개가 있을 수 있기 때문에 이 문제에 는 굉장히 많은 답이 있는데, 우리는 이 중 무전기의 통신 반경 d가 최소화되는 답을 찾고 있으므로 이 문제는 최적화문제입니다. 이것을 결정 문제 형태로 바꿔 봅시다.

decision(P, d) = 모든 기지를 하나로 연결하되, 가장 먼 두 기지 간의 거리가 d 이하인 연락망이 있는가?

이 질문이 “x 또는 그보다 좋은 답이 있는가?”의 형태를 유지하고 있다는 데 유의. 이 문제를 쉽게 풀 수 있다면 원래 문제는 decision()이 참을 반환하는 최소의 d를 찾는 형태로 바뀐다.

서로 거리가 d 이하인 기지들을 우선 전부 연결해 연락망을 만든 뒤, 이들이 하나로 연결되어 있는지를 확인. 여기서는 29장에서 다루는 그래프의 너비 우선 탐색 알고리즘을 이용하도록 하자. 서로 거리가 d 이하인 기지들 간에 간선이 있다고 가정하고 그래프를 만든 뒤, 한 기지에서 시작해 탐색 알고리즘을 이용해 다른 기지에도 전부 방문할 수 있는지를 확인하면 된다. 결정 문제를 해결하고 나면 이분법 을 이용해 원래의 최적화 문제도 해결할 수 있다. 

[ARCTIC 구현 🔗](DecisionProblem/ARCTIC.swift)

optimize()은 이분법을 활용하여 decision()이 참을 반환하는 최소의 답을 찾아낸다. 너비 우선 탐색의 시간 복잡도는 O(V+E)이고, 이 문제에서 E = O(n²)이므로, decisionArctic()의 시간 복잡도는 O(n²)이다. 시간 제한 안에 충분히 100번 계산 가능.

### 다른 해법

크루스칼의 최소 스패닝 트리 알고리즘, 플로이드 모든 쌍 최단 거리 알고리즘 등으로도 풀 수 잇다.

## [CANADATRIP](https://algospot.com/judge/problem/read/CANADATRIP)

최적화문제는 아니지만, 이 문제를푸는 열쇠 또한 원래 문제를 결정 문제로 바꾸는 데 있다. "K번째 표지판의 위치는 어디인가?”라는 문제를 다음과 같이 바꿔 보자.

decision(x) = 시작점부터 x미터 지점까지 가면서 K개 이상의 표지판을 만날 수 있는가?

우리가 원하는 답이 D라고 하면, D는 decision()이 참을 반환하는 첫 번째 지점일 것. 다시 말하면 decision(D-1)=false, decision(D)=true 여야 한다는 뜻. 이와 같은 지점을 찾는 것은 이분법으로 간단하게 구현할 수 있다.

### decision() 구현하기

decision(x)을 구현하기 위해, [0, x] 범위에 출현하는 모든 표지판의 개수를 세어 보자. i번째 도시까지의 거리를 나타내는 표지판은 [L-M, L] 구간에 출 현하므로, 두 구간이 닿아 있지 않은 경우 (x < L - M)에서는 표지판을 하나도 볼 수 없다. 이 외의 경우 [0, x] 구간과 [L - M, L] 구간의 겹치는 길이는 다음과 같다.

min(xᵢ, Lᵢ) - (Lᵢ - Mᵢ)

구간의 길이가 0이라도 표지판을 하나는 보게 되니, 이 값을 Gᵢ로 나누고 1을 더하면 i번째 도시까지의 거리를 나타내는 표지판을 몇 개나 보게 되는지를 쉽 게 계산할 수 있다. 도시의 수는 최대 5,000개밖에 되지 않으니 각 도시를 순회하며 표지판의 수를 더해 주면 된다.

[CANADATRIP 구현 🔗](DecisionProblem/CANADA.swift)

optimize()의 탐색 범위는 정해져 있기 때문에, decision()은 항상 대략 lg 8,030,000=22번 호출된다.
decision()의 수행 시간은 O(n)이기 때문에 스물 두 번정도 호출하는 데는 아무런 지장이 없습니다.

## [WITHDRAWAL](https://algospot.com/judge/problem/read/WITHDRAWAL)

[WITHDRAWAL  구현 🔗](DecisionProblem/WITHDRAWAL.swift)

decision()은 정렬과 두 개의 선형 반복문으로 구성되어 있기 때문에 O(nlgn) 의 시간 복잡도를 갖게 된다. n<=1000 이라는 점을 고려하면 시간 제한 안에 충분히 100번 계산할 수 있음을 알 수 있다.