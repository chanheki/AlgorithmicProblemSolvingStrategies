// https://www.acmicpc.net/problem/2435

/*
    부분 합 문제.
    N, K가 주어지고, N개의 정수가 주어질 때, K개의 연속된 정수의 합 중 최대값을 구하는 문제.
    N이 10만이 되면 O(N^2)으로 풀면 시간초과가 난다. (해당 백준 문제에서는 최대 100개)
    따라서 부분 합을 이용하여 O(N)으로 풀어야 한다.

    ---
    
    ret 값이 음수가 나올 수 있는 점을 고려하지 못하여 틀렸다.
    ret을 Int.min으로 초기화하고, max 함수를 이용하여 최대값을 구하면 된다.
*/

let NK = readLine()!.split(separator: " ").map{Int(String($0))!}
let (N, K) = (NK[0], NK[1]-1)
let A = readLine()!.split(separator: " ").map{Int(String($0))!}
var psum = [Int](repeating: 0, count: N)
var ret = Int.min

psum[0] = A[0]
for i in 1..<N {
	psum[i] = psum[i-1] + A[i]
}

func rangeSum(_ a: Int, _ b: Int) -> Int {
	return psum[b] - (a == 0 ? 0 : psum[a-1])
}

for i in 0..<N-K {
	ret = max(rangeSum(i, i+K), ret)
}

print(ret)
