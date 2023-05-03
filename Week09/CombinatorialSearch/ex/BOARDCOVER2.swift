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
