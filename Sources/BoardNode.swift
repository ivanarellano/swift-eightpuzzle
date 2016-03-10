struct BoardNode {

    private let prevBoard: Node<BoardNode>?
    private let boardLayout: String
    private let direction: Direction?
    private let f, g: Int
    private var h = 0

    private var inOpen = false
    private var possibleMoves: [Node<BoardNode>] = []

    enum Direction {
        case Up, Down, Left, Right

    }

    init(boardLayout: String) {
        self.init(
            prevBoard: nil,
            boardLayout: boardLayout,
            direction: nil,
            g: 0
        )
    }

    init(prevBoard: Node<BoardNode>?, boardLayout: String, direction: Direction?, g: Int) {
        self.prevBoard = prevBoard
        self.boardLayout = boardLayout
        self.direction = direction
        self.g = prevBoard != nil ? prevBoard!.data.g + 1 : g
        self.f = self.g + h

        findBlankSpace()
    }

    private mutating func pushPossibleMove(node: Node<BoardNode>) {
        possibleMoves.append(node)
    }

    private func hValue() -> Int {
        return 0
    }

    private func findBlankSpace() {
    }
}
