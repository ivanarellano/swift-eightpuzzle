var node1 = Node(data: 11)
print(node1.data, node1.next)

node1.next = Node(data: 123)
print(node1.next?.data, node1.next?.next)
