int n, k;
int 1(5000], m[500O], g[5000];
// 결정 문제: dist 지점까지 가면서 k개 이상의 표지판을 만날 수 있는가?
bool decision(int dist) { int ret = 0;
for(int i = 0; i < n; ++i)
// i번째 도시 표지판을 하나 이상 보게 되는가? if(dist >= l[i] - m[i])
ret += (min(dist, l[i]) - (ILL] - m[i])) / g[i] + 1; return ret >= k;
}
// k번째 표지판을 만나는 지점의 위치를 계산한다.
int optimizeO {
// 반복문 불변식: kiecision(lo) && decision(hi) int lo = -1, hi = 8030001; whileClo+1 < hi) {
int mid = (lo + hi) / 2; if(decision(mid))
hi = mid; else
lo = mid; }
return hi; }

var n, k 
var l = [Int]()
var m = [Int]()
var g = [Int]()
// 결정 문제: dist 지점까지 가면서 k개 이상의 표지판을 만날 수 있을까 ?
func decision(_ dist: Int) -> Bool {
    var ret = 0
    for i in 0..< n {
        // i번째 도시 표지판을 하나 이상 보게 되는가 ?
        if dist >= l[i] - m[i] {
            ret += (min(dist, l[i]) - (l[i] - m[i])) / g[i] + 1
        }
        return ret >= k
    }
}

// k번째 표지판을 만나는 지점의 위치를 개선한다.
func optimize() -> Int {
    // 반복 불변식: !decision(lo) && decision(hi)
    var lo = -1
    var hi = 8030001

    while lo+1 < hi {
        let mid = (lo + hi) / 2
        if decision(mid) {
            hi = mid
        } else {
            lo = mid
        }
    }
    return hi
}