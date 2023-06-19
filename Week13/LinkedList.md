# 연결 리스트 (Linked List)



```Swift

// Swift 에서 단방향 연결 리스트

class Node<T: Equatable> {
	var data: T?
	var next: Node?

	init(data: T?, next: Node? = nil) {
		self.data = data
		self.next = next
	}
}

class LinkedList<T: Equatable> {
	private var head: Node<T>?

	func append(data: T) {
		if head == nil {
			head = Node(data: data)
			return
		}

		var node = head
		while node?.next != nil {
			node = node?.next
		}
		node?.next = Node(data: data)
	}

	func insert(data: T, at index: Int) {
		if index == 0 {
			head = Node(data: data, next: head)
			return
		}

		var node = head
		for _ in 0..<index-1 {
			if node?.next == nil {break}
			node = node?.next
		}
		let nextNode = node?.next
		node?.next = Node(data: data)
		node?.next?.next = nextNode
	}

	func remove(at index: Int) {
		if index == 0 {
			head = head?.next
			return
		}

		var node = head
		for _ in 0..<index-1 {
			if node?.next == nil {break}
			node = node?.next
		}
		node?.next = node?.next?.next
	}

	func search(at index: Int) -> T? {
		var node = head
		for _ in 0..<index {
			if node?.next == nil {break}
			node = node?.next
		}
		return node?.data
	}

	func printAll() {
		var node = head
		while node != nil {
			print(node?.data ?? "")
			node = node?.next
		}
	}
}

var A = LinkedList<Int>()

A.append(data: 1)
A.insert(data: 2, at: 0)
A.append(data: 3)
A.append(data: 4)

A.printAll()

```
