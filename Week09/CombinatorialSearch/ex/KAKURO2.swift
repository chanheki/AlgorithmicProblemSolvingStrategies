// 비트마스크를 이용한 카쿠로의 후보 구하기

// mask에 속한 원소들의 개수를 반환한다.
func getSize(mask: Int) -> Int {
	return mask
}
// mask에 속한 원소들의 합을 반환한다.
func getSum(mask: Int) -> Int {
	return mask
}
// len칸의 합이 sum이고, 이칸들에 이미 쓰인 수의 집합이 known일 때
// 나머지 칸에 들어갈 수 있는 숫자의 집합을 반환한다.

func getCandidates(len: Int, sum: Int, known: Int) -> Int {
	//	조건에 부합하는 집합들의 교집합
	var allSets = 0
	// 1~9의 부분집합(즉 모든 짝수을 모두 생성하고, 그 중
	for set in stride(from: 0, to: 1024, by: +2) {
		// known을 포함하고 크기가 len이며 합이 sum인 집합을 모두 찾는다.
		if set & known == known && getSize(mask: set) == len && getSum(mask: set) == sum {
			allSets |= set
		}
	}
	// known에 이미 속한 숫자들은 답에서 제외한다.
	return allSets & ~known
}

// candidates[len][sum][known] = getCandidates(len, sum, known)
// 선언 및 초기화
var candidates = Array(repeating: Array(repeating: Array(repeating: 0, count: 1024), count: 46), count: 10)

// candidates[][][]를 미리 계산해둔다.
func generateCandidates() {
//	1 ~ 9의 부분 집합을 전부 생성
	for set in stride(from: 0, to: 1024, by: +2) {
//		집합의 크기와 원소의 합을 계산해둔다
		var l = getSize(mask: set)
		var s = getSum(mask: set)
		var subset = set
		while true {
			// 숫자 하나의 합이 s이고, 이미 subset숫자가 쓰여있을 때.
			// 전체 숫자의 집합이 set이 되도록 나머지 숫자를 채워넣을 수 있다.
			candidates[l][s][subset] |= (set & ~subset)
			if subset == 0 {break}
			subset = (subset - 1) & set
		}
	}
}

func put(y: Int, x: Int, val: Int) {
	// put
	for h in 0..<2 {
		known[hint[y][x][h]] += (1<<val)
	}
	vale[y][x] = val
}

func remove(y: Int, x: Int, val: Int) {
	// remove
	for h in 0..<2 {
		known[hint[y][x][h]] -= (1<<val)
	}
	vale[y][x] = 0
}

func getCandHint(hint: Int) -> Int {
	return candidates[length[hint]][sum[hint]][known[hint]]
}

func getCandCoord(y: Int, x: Int) -> Int {
	return getCandHint(hint[y][x][0]) &
			getCandHint(hint[y][x][1])
}