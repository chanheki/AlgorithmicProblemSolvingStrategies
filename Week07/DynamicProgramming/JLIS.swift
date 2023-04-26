/**
 * @author chanhihi
 * @email chanhihi55@gmail.com
 * @create date 2023/04/27
 * @modify date 2023/04/27
 * @desc [JLIS count]
 * Swiftic
 */

import Foundation

var N = Int(readLine()!)!

for _ in 0..<N {
	let n = readLine()!.split(separator: " ").map{Int(String($0))!}
	let A = readLine()!.split(separator: " ").map{Int(String($0))!}
	let B = readLine()!.split(separator: " ").map{Int(String($0))!}
	print(Set(A+B).count)
}

