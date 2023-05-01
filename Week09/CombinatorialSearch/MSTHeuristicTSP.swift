// MST를 Swift로 여기서는 다루지 않는다.

// 상호 배타적 집합 자료 구조를 구현한다.
struct DisjointSet {
	// n개의 원소로 구성된 집합 자료 구조를 만든다.
	var DisjointSet: Int
	// here가 포함된 집합의 대표를 반환한다.
	func find(here: Int) -> Int {1}
	func merge(a: Int, b: Int) -> Bool {false}
}

// 모든 도시 간의 도로를 길이 순으로 정렬해 저장해 둔다.
var edges: [(Double, (Int,Int))] = [(Double, (Int,Int))]()
// here과 시작점, 아직 방문하지 않은 도시들을 모두 연결하는 MST를 찾는다.

// Kruskal's MST적용

/*

DisjointSet sets(n);
double taken = 0;
for(int i = 0; i < edges.size(); ++i) {
int a = edges[i].second.first, b = edges[i].second.second;
if(a != 0 && a != here && visited[a]) continue;
if(b != 0 && b != here && visited[b]) continue;
if(sets.merge(a, b))
taken += edges[i].first;
}
return taken;
}
double solve0 {
// edges 초기화
edges.clearO;
for(int i = 0; i < n; ++i)
for(int j = 0; j < i; ++j)
edges.push_back(make_pair(dist[i][j]f make_pair(i, j)));
sort(edges. begin (), edges. endO);

*/