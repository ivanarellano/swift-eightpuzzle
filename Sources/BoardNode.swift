struct BoardNode {

    private static let goal = "1234567890"
    private var h: Int
    private static let blankTile: Character = "0"
    private static let squareGridSize = 3

    private let prevBoard: Node<BoardNode>?
    private let boardLayout: String
    private let direction: Direction?
    private let f, g: Int
    private let blankTilePos: (Int, Int)

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
        self.h = hValue()
        self.f = self.g + self.h
        self.blankTilePos = findTile(BoardNode.blankTile)
    }

    private mutating func pushPossibleMove(node: Node<BoardNode>) {
        possibleMoves.append(node)
    }

    private func placed() -> Int {
        return 1
    }

    private func misplaced() -> Int {
        return 1
    }

    private func hValue() -> Int {
        return 36 * misplaced() + 18 * manhattanOfFirstMisplacedTile() + manhattanOfFirstFromBlank()
    }

    private func findTile(tile: Character) -> (dividedArrayPos: Int, modulusArrayPos: Int) {
        //let index = boardLayout.characters.indexOf(tile)
        
        let fromStart = boardLayout.startIndex
        let index = fromStart.advancedBy(boardLayout.characters.count)

        return (index / BoardNode.squareGridSize, index % BoardNode.squareGridSize)
    }

    private func manhattanOfFirstMisplacedTile() -> Int {
        return 1
    }

    private func manhattanOfFirstFromBlank() -> Int {
        return 1
    }
}
