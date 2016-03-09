class NodeBacking<Element> {
    var backing: Element

    init(backing: Element) {
        self.backing = backing
    }
}

struct Node<Element> {
    var data: NodeBacking<Element>
    var next: NodeBacking<Node<Element>?>

    init(data: Element) {
        self.data = NodeBacking(backing: data)
        next = NodeBacking(backing: nil)
    }
}
