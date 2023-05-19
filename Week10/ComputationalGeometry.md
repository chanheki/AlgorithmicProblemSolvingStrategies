# [계산 기하 ComputationalGeometry ]()


## 계산 기하 (computational geometry) 알고리즘

점, 선, 다각형과 원 등 각종 기하학적 도형을 다루는 알고리즘을 계산 기하 (computational geometry) 알고리즘이라고 합니다.

## 계산 기하의 도구들

### 벡터의 구현

벡터는 방향과 거리. 벡터를 그림으로 그릴 수 있는 가장 직관적인 방법은 화살표. 화살표는 방향과 길이를 모두 나타낼 수 있기 때문.
벡터는 방향과 거리의 쌍이기 때문에, 화살표의 시작점이 어디인지 중요하지는 않다. 벡터의 시작점은 좌표 공간의 원점으로 정해두면, 화살표의 끝점의 위치를 (x, y)로만 표현할 수 있다.

[vector2 구조체 구현 🔗](ComputationalGeometry/vector2.swift)

[swift SIMD2 vector2 관련 더 알아두면 좋을 것🔗](ComputationalGeometry/vector_simd2.swift)

- 벡터의 덧셈: 두 벡터 A와 B가 주어졌을 때, 벡터의 덧셈은 각 벡터의 시작점을 원점으로 간주하고 두 벡터의 끝점을 연결하는 벡터 C를 생성합니다. 이 벡터 C는 원래의 두 벡터 A와 B의 합으로 간주됩니다. 기하학적으로 이는 벡터 A의 끝점에서 벡터 B의 시작점을 연결하면 벡터 A + B를 얻는 것으로 생각할 수 있습니다.
(두 벡터 a와 b를 더한 벡터 a+b는 b의 시작점을 a의 끝점으로 옮겼을 때 b의 끝점에서 끝나는 벡터이다. 두 벡터의 좌표를 각각 더해서 결과 벡터를 얻을 수 있다.)

- 벡터의 뺄셈: 벡터 A에서 벡터 B를 뺄 때, 벡터 B의 반대 방향으로 벡터 A를 이동시킨 벡터를 얻습니다. 이는 벡터 B의 반대 방향 벡터를 벡터 A에 더하는 것과 같습니다.(한 벡터 a에서 다른 벡터 b를 뺀 벡터 a-b는 b의 끝점에서 a의 끝점으로 가는 벡터이다. 두 벡터의 좌표를 각각 빼서 결과 벡터를 얻을 수 있다. 또한 이렇게 정의할 경우 (a-b)+b=a임을 확인할 수 있다.)

- 실수와의 곱셈: 벡터 A에 실수를 곱하면 그 벡터의 길이가 실수만큼 변하고, 실수가 음수일 경우 벡터의 방향이 반대가 됩니다. 예를 들어, 벡터 A에 2를 곱하면 그 길이는 원래의 두 배가 되고, 벡터 A에 -1을 곱하면 그 벡터의 방향이 반대가 됩니다.(한 벡터 a를 실수 r로 곱한 벡터 a*r은 a의 길이를 r배로 늘린 벡터이다. 벡터의 각 좌표에 r을 곱해서 결과 벡터를 얻을 수 있다.)

벡터의 대소 비교에서 끝점의 x 좌표가 작은 벡터일수록, 그리고 끝점의 x 좌표가 같을 경우 y 좌표가 작은 벡터 일수록 더 작은 벡터라고 계산한다. 이와 같은 구 현에는 특별한 수학적 의미는 없지만, 종종 유용하게 사용됩니다.

### 점과 직선, 선분의 표현

``` Swift
// 이와 같이 vector 구조체를 사용해서 쉽고 편하게 a가 b보다 얼마나 더 가까운지 확인가능하다. 
func howMuchClose(_ p: vector2, _ a: vector2, _ b: vector2) -> Double {
    return (b - p).norm() - (a - p).norm()
}
```

### 벡터의 내적과 외적

벡터의 내적(inner product).

두 2차원 벡터 a=(ax, ay)와 b = (bx, by)의 내적 ab는 다음과 같이 두 가지 방법으로 계산할수 있는 실수 값.

![image](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2F9anCK%2FbtsgwMlzGRG%2F67Ik23kj3axM3jJLvXlUm0%2Fimg.png)


``` Swift
// 원점에서 벡터 b가 벡터 a의 반시계 방향이면 양수, 시계 방향이면 음수,
// 평행이면 0을 반환한다.
func ccw(a: Vector2, b: Vector2) -> Double {
    return a.cross(rhs: b)
}

// 점 P를 기준으로 벡터 b가 벡터 a의 반시계 방향이면 양수, 시계 방향이면 음수,
// 평행이면 0을 반환한다.
func ccw(p: Vector2, a: Vector2, b: Vector2) -> Double {
    return ccw(a: a - p, b: b - p)
}
```

## 교차와 거리, 면적

### 직선과 직선의 교차

``` Swift
// (a, b)를 포함하는 선과 (c, d)를 포함하는 선의 교점을 x에 반환한다.
// 두 선이 평행이면 (겹치는 경우를 포함) false를, 아니면 true를 반환한다.
func lineIntersection(a: Vector2, b: Vector2, c: Vector2, d: Vector2) -> (Bool, Vector2?) {
    let det = (b - a).cross(rhs: d - c)
    // 두 선이 평행인 경우
    if abs(det) < .epsilon { return (false, nil) }
    let x = a + (b - a) * ((c - a).cross(rhs: d - c) / det)
    return (true, x)
}
```

### 선분과 선분의 교차

1. 두선분이서로 겹치지 않음
2. 두 선분이 한 점에서 닿음
3. 두 선분이 겹쳐짐
4. 한 선분이 다른 선분 안에 포함됨

``` Swift
// (a, b)와 (c, d)가 평행한 두 선분일 때 이들이 한 점에서 겹치는지 확인한다
func parallelSegments(a: Vector2, b: Vector2, c: Vector2, d: Vector2) -> (Vector2?, Bool) {
    var a = a, b = b, c = c, d = d
    if b < a { swap(&a, &b) }
    if d < c { swap(&c, &d) }
    // 한 직선 위에 없거나두 선분이 겹치지 않는 경우를우선 걸러낸다.
    if ccw(a: a, b: b, c: c) != 0 || b < c || d < a { return (nil, false) }
    // 두 선분은 확실히 겹친다. 교차점을 하나 찾자.
    let p: Vector2 = a < c ? c : a
    return (p, true)
}

// p가 (a, b)를 감싸면서 각 변이 x, y축에 평행한 최소 사각형 내부에 있는지 확인한다.
// a, b, p는 일직선 상에 있다고 가정한다.
func inBoundingRectangle(p: Vector2, a: Vector2, b: Vector2) -> Bool {
    var a = a, b = b
    if b < a { swap(&a, &b) }
    return p == a || p == b || (a < p && p < b)
}

// (a, b) 선분과 (c, d) 선분의 교점을 p에 반환한다.
// 교점이 여러 개일 경우 아무 점이나 반환한다.
// 두 선분이 교차하지 않을 경우 false# 반환한다.
func segmentIntersection(a: Vector2, b: Vector2, c: Vector2, d: Vector2) -> (Vector2?, Bool) {
    var p: Vector2? = nil
    // 두 직선이 평행인 경우를 우선 예외로 처리한다.
    if let intersection = lineIntersection(a: a, b: b, c: c, d: d).0 {
        p = intersection
    } else {
        return parallelSegments(a: a, b: b, c: c, d: d)
    }
    // p가 두 선분에 포함되어 있는 경우에만 참을 반환한다.
    if let p = p {
        return (p, inBoundingRectangle(p: p, a: a, b: b) && inBoundingRectangle(p: p, a: c, b: d))
    }
    return (nil, false)
}

```

### 선분과 선분의 교차: 교차점이 필요 없을 때

``` Swift
// 두 선분이 서로 접촉하는지 여부를 반환한다.
func segmentIntersects(a: Vector2, b: Vector2, c: Vector2, d: Vector2) -> Bool {
    var a = a, b = b, c = c, d = d
    let ab = ccw(a: a, b: b, c: c) * ccw(a: a, b: b, c: d)
    let cd = ccw(a: c, b: d, c: a) * ccw(a: c, b: d, c: b)
    // 두 선분이 한 직선 위에 있거나 끝점이 겹치는 경우
    if ab == 0 && cd == 0 {
        if b < a { swap(&a, &b) }
        if d < c { swap(&c, &d) }
        return !(b < c || d < a)
    }
    return ab <= 0 && cd <= 0
}
```

### 점과 선 사이의 거리

``` Swift
// 점 P에서 (a, b) 직선에 내린 수선의 발을 구한다.
func perpendicularFoot(p: Vector2, a: Vector2, b: Vector2) -> Vector2 {
    return a + (p - a).project(rhs: b - a)
}

// 점 P와 (a, b) 직선 사이의 거리를 구한다.
func pointToLine(p: Vector2, a: Vector2, b: Vector2) -> Double {
    return (p - perpendicularFoot(p: p, a: a, b: b)).norm
}
```

---

## PINBALL 

[PINBALL sudo 🔗](ComputationalGeometry/PINBALL.swift)

---

## POLYGON

[POLYGON sudo 🔗](ComputationalGeometry/POLYGON.swift)

---

## TREASURE

[TREASURE sudo 🔗](ComputationalGeometry/TREASURE.swift)

---

## NERDS

[NERDS sudo 🔗](ComputationalGeometry/NERDS.swift)

---

## 계산 기하 알고리즘 디자인 패턴

- 평면 스위핑
- 직사각형 합집합의 면적
- 다각형 교집합의 넓이 구하기
- 교차하는 선분들
- 회전하는 캘리퍼스

---

## 자주하는 실수와 유의점들

- 퇴화도형
- 직교 좌표계와 스크린 좌표계
- 다른 실수들
