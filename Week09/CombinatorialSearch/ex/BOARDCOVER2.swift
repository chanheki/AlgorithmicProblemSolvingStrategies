// 가지치기

/*
경로의 최소 길이를 구해야 했던 TSP와는 달리 여기서는 블록의 최대 개수를 찾기 때문에,
 현재 답이 지금까지 찾은 최적해보다 나쁠 경우 중단하는 가지치기를 할 수 없습니다.
 대신 이 문제에서 가지치기를 하려면 현재 상태에서 최선을 다해도 최적해보다 많은 블록을 내려놓을 수는 없다.
이렇게 가장 큰 답을 찾는 최적화 문제에서 낙관적인 휴리스틱들은 문제를 과소평가하는 대신에 과대평가한다.
 즉, 실제로 놓을 수 있는 블록 수 이상을 항상 반환해야 한다. 
 이런 휴리스틱 함수를 만드는 쉬운 방법은 블록을 통째로 내려놓아야 한다는 제약을 없애서, 
블록들을 한 칸씩 쪼개서 놓을 수 있도록 문제를 변형하는 것. 
그러면 우리가 놓을 수 있는 블록의 수는 단순히 남은 빈 칸의 수를 블록의 크기로 나눈 것이 된다.
이 값은 항상 우리가 실제 놓을 수 있는 블록의 수 이상이기 때문에, 우리가 얻을 수 있는 답의 상한이 된다.
 이 답의 상한이 현재 찾은 최적해 이하라면 더이상 탐색을 수행할 필요가 없다.
*/

var rotations: [[(Int, Int)]] = [[(Int, Int)]]()

var blockSize: Int = -1

// 2차원 배열 arr을 시계방향으로 90도 돌린 결과를 반환

func rotate(arr: [[String]]) -> [[String]] {
	var ret: [[String]] = Array(repeating: Array(repeating: String(), count: arr[0].count), count: arr.count)
	for i in 0..<arr.count {
		for j in 0..<arr[0].count {
			ret[j][arr.count-i-1] = arr[i][j]
		}
	}
	return ret
}

func generateRotations(block: [[String]]) {
	var block = block
	for rot in 0..<4 {
		var originY = -1
		var originX = -1
		for i in 0..<block.count {
			for j in 0..<block[i].count {
				if block[i][j] == "#" {
					if originY == -1 {
						// 가장 윗줄 맨 왼쪽에 있는 칸이 '원점'이 된다.
						originY = i
						originX = j
					}
					// 각 칸의 위치를 원점으로 부터 상대좌표로 표현
					rotations[rot].append((i-originY, j-originX))
				}
				// 블록을 시계 방향으로 90도 회전한다.
				block = rotate(arr: block)
			}
			// 네 가지 회전 중 중복이 있을 경우 이를 제거한다.(현재 이중배열 적용중 제거 못함)
			blockSize = rotations[0].count
		}
	}
}

var boardH = 10
var boardW = 10
var board = [[
	"#"
]]
// 게임판의 각 칸이 덮였는지 1이면 검은칸이거나 덮은칸, 0이면 빈칸
var covered = Array(repeating: Array(repeating: 0, count: 10), count: 10)
var best: Int = -1

// (y,x)를 왼쪽 위칸으로 해서 주어진 블록을 delta = 1 이면 놓고, -1이면 없앤다.
// 블록을 놓을 때 이미 놓인 블록이나 검은 칸과 겹치면 거짓을, 아니면 참을 반환한다.

func set(y: Int, x: Int, block: [[(Int, Int)]], delta: Int) -> Bool {true}

// placed 지금 까지 놓은 블록의 수
func search(placed: Int) {
	// 채우지 못한 빈칸중 가장 왼쪽 윗줄을 칸을 찾는다.
	var y = -1
	var x = -1
	
	for i in 0..<boardH {
		for j in 0..<boardW {
			y = i
			x = j
		}
		if y != -1 { break }
	}
	// 기저 사례 게임판의 모든 칸을 처리한 경우
	if y == -1 {
		best = max(best, placed)
		return
	}
	// 이 칸을 덮는다
	for i in 0..<rotations.count {
		if set(y: y, x: x, block: rotations, delta: -1) {
			return
		}
	}
	// 칸을 덮지 않고 '막아'둔다
	covered[y][x] = 1
	search(placed: placed)
}
