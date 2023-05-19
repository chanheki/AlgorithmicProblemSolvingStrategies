import simd

let v1 = simd_double2(x: 3.0, y: 4.0)
let v2 = simd_double2(x: 1.0, y: 2.0)

// 덧셈
let sum = v1 + v2 // (4.0, 6.0)

// 뺄셈
let diff = v1 - v2 // (2.0, 2.0)

// 내적
let dotProduct = simd_dot(v1, v2) // 11.0

// 벡터의 크기
let length = length(v1) // 5.0

// 정규화
let normalized = normalize(v1) // (0.6, 0.8)

// X축과의 각도 계산은 atan2와 같은 함수를 직접 사용해야 함
let angle = atan2(v1.y, v1.x)
