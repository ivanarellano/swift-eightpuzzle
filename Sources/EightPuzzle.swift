import Glibc

struct EightPuzzle {
    
    static func manhattan(x1: Int, y1: Int, x2: Int, y2: Int) -> Int {
        return abs(x1 - x2) + abs(y1 - y2)
    }

    func solve() {
        populateTree()
        getPath()
    }

    private func populateTree() {
    }

    private func moveBlank(boardLayout: String, row: Int, column: Int) -> String {
        return ""
    }

    private func checkBounds(row: Int, column: Int) -> Bool {
        return false
    }

    private func getDirectionOfMove(row: Int, column: Int) -> String {
        return ""
    }
/*
    private func inClosed(node: Node<Element>) -> Bool {
    }

    private func generatePossibleMoves(node: Node<Element>) {
    }
*/
    private func getPath() {
    }

    /*
    * printBoard()
    * printBoardPath()
    * printClosedList()
    */
}
