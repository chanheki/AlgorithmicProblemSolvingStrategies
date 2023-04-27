/**
 * @author chanhihi
 * @email chanhihi55@gmail.com
 * @create date 2023/04/27
 * @modify date 2023/04/27
 * @desc [탐욕법 Greedy]
 */

func order(russian: [Int], korean: [Int]) -> Int {
	let n = russian.count
	var wins = 0
	// 아직 남아 있는 선수들의 레이팅
	var rating = korean.sorted()
	
	for rus in 0..<n {
		// 가장 레이팅이 높은 한국 선수가 이길 수 없는 경우
		// 가장 레이팅이 낮은 선수와 경기시킨다.
		if rating.last! < russian[rus] {
			rating.removeFirst()
		} else {
			for (i,v) in rating.enumerated() {
				if v >= russian[rus] {
					rating.remove(at: i)
					break
				}
			}
			wins += 1
		}
	}
	return wins
}

print(order(russian: [1,2,3,4,5], korean: [1,2,3,4,2]))