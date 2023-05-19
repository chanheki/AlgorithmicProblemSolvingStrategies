import Foundation

let PI = 2.0 * acos(0.0)

struct Vector2 {
    var x: Double
    var y: Double

    init(x: Double = 0, y: Double = 0) {
        self.x = x
        self.y = y
    }
    
    // 두 벡터의 비교
    static func ==(lhs: Vector2, rhs: Vector2) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    static func <(lhs: Vector2, rhs: Vector2) -> Bool {
        return lhs.x != rhs.x ? lhs.x < rhs.x : lhs.y < rhs.y
    }
    
    // 벡터의 덧셈과 뺄셈
    static func +(lhs: Vector2, rhs: Vector2) -> Vector2 {
        return Vector2(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func -(lhs: Vector2, rhs: Vector2) -> Vector2 {
        return Vector2(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    // 실수로 곱셈
    func multiply(by value: Double) -> Vector2 {
        return Vector2(x: x * value, y: y * value)
    }
    
    // 벡터의 길이를 반환한다.
    func norm() -> Double {
        return hypot(x, y)
    }
    
    // 방향이 같은 단위 벡터 (unit vector)를 반환한다.
    // 영벡터에 대해 호출한 경우 반환 값은 정의되지 않는다.
    func normalize() -> Vector2 {
        let n = norm()
        return Vector2(x: x / n, y: y / n)
    }
    
    // X축의 양의 방향으로부터 이 벡터까지 반시계 방향으로 잰 각도
    func polar() -> Double {
        return fmod(atan2(y, x) + 2*PI, 2*PI)
    }
    
    // 내적/외적의 구현
    func dot(_ vector: Vector2) -> Double {
        return x * vector.x + y * vector.y
    }

    func cross(_ vector: Vector2) -> Double {
        return x * vector.y - vector.x * y
    }
    
    // 이 벡터를 rhs에 사영한 결과
    func project(_ vector: Vector2) -> Vector2 {
        let r = vector.normalize()
        return r.multiply(by: r.dot(self))
    }
}
