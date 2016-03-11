struct BoardNode {

    private static let goal = "1234567890"
    private static let blankTile: Character = "0"
    private static let squareGridSize = 3

    private let prevBoard: Node<BoardNode>?
    private let boardLayout: String
    private let direction: Direction?
    private var f: Int?
    private let g: Int
    private let h: Int?
    // private let blankTilePos: (Int, Int)?

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
        //self.f = self.g + self.h
        self.h = 1
        //self.blankTilePos = findTile(BoardNode.blankTile)
    }

    private mutating func pushPossibleMove(node: Node<BoardNode>) {
        possibleMoves.append(node)
    }

    private func placed() -> Int {
        var misplaced = false
        var placed = 0
        var index = 0

        if boardLayout.characters.count == BoardNode.goal.characters.count {
            while misplaced == false && index < BoardNode.squareGridSize * BoardNode.squareGridSize {
                for i in boardLayout.characters.indices {
                    if boardLayout[i] != BoardNode.goal[BoardNode.goal.startIndex.advancedBy(index)] {
                        misplaced = true
                    } else {
                        placed += 1
                    }
                    index += 1
                }
            }
        }

        return placed
    }

    private func misplaced() -> Int {
        return 9 - placed()
    }

    private func hValue() -> Int {
        return 36 * misplaced() + 18 * manhattanOfFirstMisplacedTile() + manhattanOfFirstFromBlank()
    }

    private func findTile(tile: Character) -> (dividedArrayPos: Int, modulusArrayPos: Int) {
        var index = 0
        for i in boardLayout.characters.indices {
            if boardLayout[i] == tile {
                break
            }
            index += 1
        }

        return (index / BoardNode.squareGridSize, index % BoardNode.squareGridSize)
    }

    private func manhattanOfFirstMisplacedTile() -> Int {
        return 1
    }

    private func manhattanOfFirstFromBlank() -> Int {
        return 1
    }
}
