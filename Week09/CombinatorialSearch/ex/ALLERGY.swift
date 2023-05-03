var n: Int
var m: Int
// eaters[food] = food를 먹을 수 잇는 친구들의 번호
var eaters = Array(repeating: 0, count: 50)
var best = 0
// food 이번에 고려해야 할 음식의 번호
// edible 지금까지 고른 음식 중 i번 친구가 먹을 수 있는 음식의 수
// chosen 지금까지 고른 음식의 수

func slowSearch(food: Int, edible: [Int], chosen: Int) {
//	간단한 가지치기
	if chosen >= best { return }
//	기저사례: 모든 음식에 대해 만들지 여부를 결정했으면
//	모든 친구가 음식을 먹을 수 있는지 확인하고 그렇다면 최적해를 갱신한다.
	if food == m {
		if edible.firstIndex(of: 0) != nil {
			best = chosen
			return
		}
	}
	// food를 만들지 않는 경우
	slowSearch(food: food+1, edible: edible, chosen: chosen)
	// 만드는 경우
	for j in 0..<eaters[food].count {
		edible[eaters[food][j]] += 1
	}
	slowSearch(food: food+1, edible: edible, chosen: chosen+1)
    for j in 0..<eaters[food].count {
		edible[eaters[food][j]] -= 1
	}
}


// MARK: - 

var canEat = Array(repeating: 0, count: 50)
var eaters = Array(repeating: 0, count: 50)

var best = 0

// chosen 지금까지 선택한 음식의 수
// edible[i] 지금까지 고른 음식 중 i번 친구가 먹을 수 있는 음식의 수

func search(edible: [Int], chosen: Int) {
	// 간단한 가지치기
	if chosen >= best { return }
	var first = 0

	while first < n && edible[first] > 0 {first += 1}
	// 모든 친구가 먹을 음식이 있는 경우 종료한다.
	if first == n {
		best = chosen
		return 
	}
	// 이 친구가 먹을 수 있는 음식을 하나 만든다.
	for i in 0..<canEat[first].count {
		var food = canEat[first][i]
		for j in 0..<eaters[food].count {
			edible[eaters[food][j]] += 1
		}
		search(edible: edible, chosen: chosen+1)
		for j in 0..<eaters[food].count {
			edible[eaters[food][j]] -= 1
		}
	}
}