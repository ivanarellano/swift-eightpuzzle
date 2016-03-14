struct BoardNode {

    enum Direction {
        case Up, Down, Left, Right
    }

    private static func manhattan(x1: Int, y1: Int, x2: Int, y2: Int) -> Int {
        return abs(x1 - x2) + abs(y1 - y2)
    }
    private static let goal = "123456780"
    private static let blankTile: Character = "0"
    private static let squareGridSize = 3
    private static let totalTiles = BoardNode.squareGridSize * BoardNode.squareGridSize

    private let prevBoard: Node<BoardNode>?
    private let boardLayout: String
    private let direction: Direction?
    private let g: Int

    private var inOpen = false
    private var possibleMoves = [Node<BoardNode>]()
    private var f: Int {
        get {
            return g + h
        }
    }
    private var h: Int {
        get {
            return 36 * misplaced() + 18 * manhattanOfFirstMisplacedTileFromCorrectPlace() + manhattanOfFirstMisplacedTileFromBlank()
        }
    }
    private var blankTileCoord: Coordinate {
        get {
            return findCoordInBoard(boardLayout, tile: BoardNode.blankTile)
        }
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
    }

    private func getDirection(coord: Coordinate) -> Direction? {
        switch coord {
        case (0, 1):
            return .Down
        case (0, -1):
            return .Up
        case (1, 0):
            return .Right
        case (-1, 0):
            return .Left
        default:
            return nil
        }

    }

    private mutating func pushPossibleMove(node: Node<BoardNode>) {
        possibleMoves.append(node)
    }

    func findCoordInBoard(board: String, tile: Character) -> Coordinate {
        var index = 0
        for i in board.characters.indices {
            if board[i] == tile {
                break
            } else {
                index += 1
            }
        }

        return (index / BoardNode.squareGridSize, index % BoardNode.squareGridSize)
    }

    func placed() -> Int {
        var counter = 0

        if boardLayout.characters.count == BoardNode.goal.characters.count {
            for i in boardLayout.characters.indices {
                let goalTileAtCurrentIndex = BoardNode.goal[BoardNode.goal.startIndex.advancedBy(counter)]

                if boardLayout[i] != goalTileAtCurrentIndex {
                    break
                } else {
                    counter += 1
                }
            }
        } else {
            // throw error about non-matching strings
        }

        return counter
    }

    func misplaced() -> Int {
        return BoardNode.totalTiles - placed()
    }

    func manhattanOfFirstMisplacedTileFromCorrectPlace() -> Int {
        var counter = 0
        var manhattanDistance = 0

        for i in boardLayout.characters.indices {

            let goalTileAtMisplacedIndex = BoardNode.goal[BoardNode.goal.startIndex.advancedBy(counter)]
            if boardLayout[i] != goalTileAtMisplacedIndex {

                for j in boardLayout.startIndex.advancedBy(counter)...boardLayout.characters.endIndex.predecessor() {

                    if boardLayout[j] == goalTileAtMisplacedIndex {
                        let misplacedTileCoord = findCoordInBoard(boardLayout, tile: boardLayout[j])
                        let correctTileCoord = findCoordInBoard(BoardNode.goal, tile: goalTileAtMisplacedIndex)

                        manhattanDistance = BoardNode.manhattan(misplacedTileCoord.x, y1: misplacedTileCoord.y, x2: correctTileCoord.x, y2: correctTileCoord.y)
                        break
                    }
                }

                break
            } else {
                counter += 1
            }
        }

        return manhattanDistance
    }

    func manhattanOfFirstMisplacedTileFromBlank() -> Int {
        var counter = 0
        var manhattanDistance = 0

        for i in boardLayout.characters.indices {

            let goalTileAtMisplacedIndex = BoardNode.goal[BoardNode.goal.startIndex.advancedBy(counter)]
            if boardLayout[i] != goalTileAtMisplacedIndex {
                let misplacedTileCoord = findCoordInBoard(BoardNode.goal, tile: goalTileAtMisplacedIndex)
                manhattanDistance = BoardNode.manhattan(blankTileCoord.x, y1: blankTileCoord.y, x2: misplacedTileCoord.x, y2: misplacedTileCoord.y)
            } else {
                counter += 1
            }
        }

        return manhattanDistance
    }
}
