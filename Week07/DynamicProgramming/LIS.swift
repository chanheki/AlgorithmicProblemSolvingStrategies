/**
 * @author chanhihi
 * @email chanhihi55@gmail.com
 * @create date 2023/04/28
 * @modify date 2023/04/28
 * @desc [DP / brute force]
 */

func lis(_ A: [Int]) -> Int {
	if A.isEmpty { return 0 }
	var ret = 1
	for i in 0..<A.count {
		var B = [Int]()
		for j in stride(from: i+1, to: A.count, by: 1) {
			if A[i] < A[j] {
				B.append(A[j])
			}
			ret = max(ret, 1 + lis(B))
		}
	}
	return ret
}