struct BoardNode {

    private let node: Node<String>
    private var possibleMoves: [Node<String>] = []

    mutating func pushPossibleMove(node: Node<String>) {
        possibleMoves.append(node)
    }
}
