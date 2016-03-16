struct EightPuzzle {
    
    var head: Board
    var tail: Board?
    var g = 1
    
    var closedList = [Board]()
    var solvedList = [Board]()
    var openList = PriorityQueue<Board>(ascending: true)
    
    init(board: String) {
        head = Board(boardLayout: board)
    }
    
    mutating func solve() {
        populateTree()
        getPathForSolution()
    }
    
    private mutating func populateTree() {
        var currentNode: Board?
        
        openList.push(head)
        
        while !openList.isEmpty {
            currentNode = openList.pop()
            
            currentNode?.inOpen = false
            closedList.append(currentNode!)
            
            if currentNode?.boardLayout == Board.goal {
                tail = currentNode
                return
            }
            
            let exploredNode = possibleMovesForNode(currentNode!)
            
            for child in exploredNode.possibleMoves {
                if !inClosed(child.data) {
                    child.data.inOpen = true
                    openList.push(child.data)
                }
            }
            
            g += 1
        }
    }
    
    private func possibleMovesForNode(node: Board) -> Board {
        var exploredNode = node
        
        for row in -1...1 {
            for column in -1...1 {
                
                if abs(row) != abs(column) {
                    let coord = Coordinate(exploredNode.blankTileCoord.x + row, exploredNode.blankTileCoord.y + column)
                    if node.checkBounds(coord.x, column: coord.y) {
                        let newBoard = Board(
                            prevBoard: NodeBacking(data: exploredNode),
                            boardLayout: moveBlankForBoard(exploredNode.boardLayout, row: coord.x, column: coord.y),
                            direction: getDirection(Coordinate(row, column)),
                            g: g
                        )
                        
                        exploredNode.appendPossibleMove(newBoard)
                    }
                }
            }
        }
        
        return exploredNode
    }
    
    private func moveBlankForBoard(boardLayout: String, row: Int, column: Int) -> String {
        let source = row * 3 + column
        var output = boardLayout
        
        let range = output.characters.indexOf(Board.blankTile)!..<(output.characters.indexOf(Board.blankTile)?.successor())!
        output.replaceRange(range, with: String(output[output.startIndex.advancedBy(source)]))
        
        output.removeAtIndex(output.startIndex.advancedBy(source))
        output.insert(Board.blankTile, atIndex: output.startIndex.advancedBy(source))
        
        return output
    }
    
    private func getDirection(coord: Coordinate) -> Board.Direction? {
        switch coord {
        case (1, 0):
            return .Down
        case (-1, 0):
            return .Up
        case (0, 1):
            return .Right
        case (0, -1):
            return .Left
        default:
            return nil
        }
    }
    
    
    private func inClosed(node: Board) -> Bool {
        for closedNode in closedList {
            if node.boardLayout == closedNode.boardLayout {
                return true
            }
        }
        
        return false
    }
    
    mutating private func getPathForSolution() {
        while tail?.prevBoard != nil {
            solvedList.append(tail!)
            tail = tail?.prevBoard?.data
        }
        
        solvedList = solvedList.reverse()
    }
    
    func printBestPath() {
        var counter = 0
        for node in solvedList {
            print("\(counter). \(node.direction!)")
            
            var output = ""
            var columnCounter = 1
            for tile in node.boardLayout.characters.indices {
                output += "| \(node.boardLayout[tile])"
                if columnCounter % 3 == 0 {
                    output += " |\n"
                } else if tile == node.boardLayout.endIndex.predecessor() {
                    output += " |"
                }
                columnCounter += 1
            }
            print(output)
            counter += 1
        }
        
    }
    
    func printExaminedBoards() {
        let endings = "#LOOP. BOARD G+H=F"
        print("- Examined Boards - \n\(endings)")
        var counter = 0
        for node in closedList {
            print("\(counter). \(node.boardLayout) \(node.g)+\(node.h)=\(node.f)")
            counter += 1
        }
        print(endings)
    }
}
