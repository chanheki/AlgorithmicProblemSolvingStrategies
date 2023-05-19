let MAX_GAMES = 2000000000
let UNREACHABLE = Int64(MAX_GAMES) * 100
let RATIO_CHANGE = 100

func neededGames(total: Int64, won: Int64) -> Int64 {
	// 우선 승률이 올라가지 않을 경우를 먼저 계산
	if ratio(total: total, wins: won) == ratio(total: total+UNREACHABLE, wins: won+UNREACHABLE) {
		return -1
	}

	var lo: Int64 = 0, hi: Int64 = UNREACHABLE
	while lo + 1 < hi {
		let mid = (lo + hi) / 2
		if ratio(total: total, wins: won) >= ratio(total: total+mid, wins: won+mid) {
			lo = mid
		} else {
			hi = mid
		}
	}
	return hi
}

func ratio(total: Int64, wins: Int64) -> Int64 {
	return (wins * 100) / total
}

// Test
print(neededGames(total: 10, won: 8))
print(neededGames(total: 100, won: 80))
print(neededGames(total: 47, won: 47))
print(neededGames(total: 99000, won: 0))
print(neededGames(total: 1000000000, won: 470000000))
print(neededGames(total: 999, won: 529))

// Floating Point Error
print(neededGames(total: 29, won: 100))
print(neededGames(total: 57, won: 100))
print(neededGames(total: 58, won: 100))

