struct Board: Comparable {
    
    enum Direction {
        case Up, Down, Left, Right
    }
    
    private static func manhattan(x1: Int, y1: Int, x2: Int, y2: Int) -> Int {
        return abs(x1 - x2) + abs(y1 - y2)
    }
    private static let squareGridSize = 3
    private static let totalTiles = Board.squareGridSize * Board.squareGridSize
    static let blankTile: Character = "0"
    static let goal = "123456780"

    let direction: Direction?
    let g: Int
    let prevBoard: NodeBacking<Board>?
    let boardLayout: String
    
    var f: Int {
        get {
            return g + h
        }
    }
    var h: Int {
        get {
            return 36 * misplaced() + 18 * manhattanOfFirstMisplacedTileFromCorrectPlace() + manhattanOfFirstMisplacedTileFromBlank()
        }
    }
    var blankTileCoord: Coordinate {
        get {
            return findCoordInBoard(boardLayout, tile: Board.blankTile)
        }
    }
    var inOpen = false
    var possibleMoves = [NodeBacking<Board>]()
    
    init(boardLayout: String) {
        self.init(
            prevBoard: nil,
            boardLayout: boardLayout,
            direction: nil,
            g: 0
        )
    }
    
    init(prevBoard: NodeBacking<Board>?, boardLayout: String, direction: Direction?, g: Int) {
        self.prevBoard = prevBoard
        self.boardLayout = boardLayout
        self.direction = direction
        self.g = prevBoard != nil ? prevBoard!.data.g + 1 : g
    }
    
    func checkBounds(row: Int, column: Int) -> Bool {
        return row < Board.squareGridSize && row >= 0 && column < Board.squareGridSize && column >= 0
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
        
        return (index / Board.squareGridSize, index % Board.squareGridSize)
    }
    
    func placed() -> Int {
        var counter = 0
        
        if boardLayout.characters.count == Board.goal.characters.count {
            for i in boardLayout.characters.indices {
                let goalTileAtCurrentIndex = Board.goal[Board.goal.startIndex.advancedBy(counter)]

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
        return Board.totalTiles - placed()
    }
    
    func manhattanOfFirstMisplacedTileFromCorrectPlace() -> Int {
        var counter = 0
        var manhattanDistance = 0
        
        for i in boardLayout.characters.indices {
            
            let goalTileAtMisplacedIndex = Board.goal[Board.goal.startIndex.advancedBy(counter)]
            if boardLayout[i] != goalTileAtMisplacedIndex {
                
                for j in boardLayout.startIndex.advancedBy(counter)...boardLayout.characters.endIndex.predecessor() {
                    
                    if boardLayout[j] == goalTileAtMisplacedIndex {
                        let misplacedTileCoord = findCoordInBoard(boardLayout, tile: boardLayout[j])
                        let correctTileCoord = findCoordInBoard(Board.goal, tile: goalTileAtMisplacedIndex)
                        
                        manhattanDistance = Board.manhattan(misplacedTileCoord.x, y1: misplacedTileCoord.y, x2: correctTileCoord.x, y2: correctTileCoord.y)
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
            
            let goalTileAtMisplacedIndex = Board.goal[Board.goal.startIndex.advancedBy(counter)]
            if boardLayout[i] != goalTileAtMisplacedIndex {
                let misplacedTileCoord = findCoordInBoard(Board.goal, tile: goalTileAtMisplacedIndex)
                manhattanDistance = Board.manhattan(blankTileCoord.x, y1: blankTileCoord.y, x2: misplacedTileCoord.x, y2: misplacedTileCoord.y)
            } else {
                counter += 1
            }
        }
        
        return manhattanDistance
    }
    
    mutating func appendPossibleMove(node: Board) {
        possibleMoves.append(NodeBacking(data: node))
    }
}

func < (lhs: Board, rhs: Board) -> Bool {
    return lhs.f < rhs.f
}

func == (lhs: Board, rhs: Board) -> Bool {
    return lhs.f == rhs.f
}