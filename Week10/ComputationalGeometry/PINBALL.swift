// https://algospot.com/judge/problem/read/PINBALL

// vector의 개념을 이용하여 풀이

// 1. 문제를 간단하게 만든다
// 공은 반지름이 1인원일때, 공을 점으로 바꾸고 모든 장애물들의 반지름을 1증가시키면 
// 공을 점으로 생각하고 풀 수 있다.


// 2. 상태 표현과 시뮬레이션
// 현재 공의 위치와 방향
// 충돌할 장애물을 찾고 기저사례를 찾아서 끝내면된다.

// 3. 충돌 시점 찾기
// 벡터연산을 통하여 찾는다.

// 4. 반사처리
// 벡터 반사를 사영

