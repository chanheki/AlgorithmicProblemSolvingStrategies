import Foundation

var PI = 2.0 * acos(0.0)
// 2차원 벡터를 표현한다.

struct Vector2 {
    var x: Double
    var y: Double
    
    // 기본 생성자
    init(x: Double = 0, y: Double = 0) {
        self.x = x
        self.y = y
    }
    
    // 동등 비교 연산자
    static func == (lhs: Vector2, rhs: Vector2) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
    // 크기 비교 연산자
    static func < (lhs: Vector2, rhs: Vector2) -> Bool {
        return lhs.length() < rhs.length()
    }
    
    // 벡터 덧셈 연산자
    static func + (lhs: Vector2, rhs: Vector2) -> Vector2 {
        return Vector2(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    // 벡터 뺄셈 연산자
    static func - (lhs: Vector2, rhs: Vector2) -> Vector2 {
        return Vector2(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    // 스칼라 곱 연산자
    static func * (lhs: Vector2, scalar: Double) -> Vector2 {
        return Vector2(x: lhs.x * scalar, y: lhs.y * scalar)
    }
    
    // 벡터 길이 반환 함수
    func length() -> Double {
        return sqrt(x * x + y * y)
    }
    
    // 벡터 각도 반환 함수
    func angle() -> Double {
        return atan2(y, x)
    }
    // X축의 양의 방향으로부터 이 벡터까지 반시계 방향으로 잰 각도
    func polar() -> Double{
        return fmod(atan2(y, x) + 2*PI, 2*PI)
    }
    
    // 벡터 내적 연산자
    static func * (lhs: Vector2, rhs: Vector2) -> Double {
        return lhs.x * rhs.x + lhs.y * rhs.y
    }
    
    // 벡터 외적 연산자
    static func ^ (lhs: Vector2, rhs: Vector2) -> Double {
        return lhs.x * rhs.y - lhs.y * rhs.x
    }
}

// 우변 스칼라 곱 연산자
func * (scalar: Double, rhs: Vector2) -> Vector2 {
    return rhs * scalar
}

