// Minesweeper
// Note: The algorithms have not being tested

import Foundation

class Cell {
    var row: Int
    var column: Int
    let isBomb: Bool
    var number: Int
    var isExposed: Bool
    var isGuess: Bool
    
    init(row: Int, column: Int, isBomb: Bool) {
        self.row = row
        self.column = column
        self.isBomb = isBomb
        self.number = 0
        self.isExposed = false
        self.isGuess = false
    }
    
    var isBlank: Bool {
        return self.number == 0 && !self.isBomb
    }
    
    func flip() -> Bool {
        self.isExposed = true
        return !self.isBomb
    }
    
    func toggleGuess() -> Bool {
        if !self.isExposed {
            self.isGuess = !self.isGuess
        }
        return self.isGuess
    }
}

struct UserPlay {
    let row: Int
    let column: Int
    let isGuess: Int
}

class Board {
    private(set) var cells: [[Cell]]!
    private(set) var bombs: [Cell]!
    var numRemaining: Int
    
    init(rows: Int, columns: Int, bombsNumber: Int) {
        self.numRemaining = rows * columns
        let createdBoard = self.createBoard(rows: rows, columns: columns, bombsNumber: bombsNumber)
        self.cells = createdBoard.cells
        self.bombs = createdBoard.bombs
        self.setNumbersForCells()
    }
    
    private func createBoard(rows: Int, columns: Int, bombsNumber: Int) -> (cells: [[Cell]], bombs: [Cell]) {
        var cells = [[Cell]]()
        var bombs = [Cell]()
        let cellsNumber = rows * columns
        for i in 0..<rows {
            var row = [Cell]()
            for j in 0..<columns {
                let isBomb = (i * columns + j) < bombsNumber
                let cell = Cell(row: i, column: j, isBomb: isBomb)
                row.append(cell)
                bombs.append(cell)
            }
            cells.append(row)
        }
        
        for i in 0..<cellsNumber {
            let rIndex = Int(arc4random()) % cellsNumber
            if i != rIndex {
                continue
            }
            let curCell = cells[i / columns][i % columns]
            let ranCell = cells[rIndex / columns][rIndex % columns]
            let tmp = (curCell.row, curCell.column)
            curCell.row = ranCell.column
            curCell.column = ranCell.column
            ranCell.row = tmp.0
            ranCell.column = tmp.1
        }
        return (cells, bombs)
    }
    
    private func inBounds(row: Int, column: Int) -> Bool {
        return row >= 0 && row < self.rowsNumber && column >= 0 && column < self.columnsNumber
    }
    
    private func setNumbersForCells() {
        let deltas = [
                        (-1, -1), (0, -1), (1, -1),
                        (-1, 0 ),          (1, 0 ),
                        (-1, 1 ), (0, 1 ), (1, 1 )
                     ]
        for bombCell in bombs {
            for delta in deltas {
                let dRow = bombCell.row + delta.0
                let dColumn = bombCell.column + delta.1
                if self.inBounds(row: dRow, column: dColumn) {
                    let cell = self.cells[dRow][dColumn]
                    cell.number += 1
                }
            }
        }
    }
    
    var rowsNumber: Int {
        return self.cells.count
    }
    
    var columnsNumber: Int {
        if self.rowsNumber > 0 {
            return self.cells[0].count
        } else {
            return 0
        }
    }
    
    var bombsNumber: Int {
        return self.bombs.count
    }
    
    func flipCell(cell: Cell) {
        // Flip a cell
    }
    
    func expandBlank(cell: Cell) {
        // Flips the blank cells around the indicated cell
        let deltas = [
            (-1, -1), (0, -1), (1, -1),
            (-1, 0 ),          (1, 0 ),
            (-1, 1 ), (0, 1 ), (1, 1 )
        ]
        var cellsToCheck = [cell]
        while let cellToCheck = cellsToCheck.first {
            for delta in deltas {
                let dRow = cellToCheck.row + delta.0
                let dColumn = cellToCheck.column + delta.1
                if self.inBounds(row: dRow, column: dColumn) {
                    let cell = self.cells[dRow][dColumn]
                    if cell.isBlank && cell.flip() {
                        cellsToCheck.append(cell)
                    }
                }
            }
        }
    }
    
    func playFlip(_ userPlay: UserPlay) -> (success: Bool, state: GameState){
        // Makes a move and execute some actions derived of the move,
        // Like lose, win, explone a mine, put a flag (guess), etc
        return (true, .won)
    }
}

enum GameState {
    case won
    case lost
    case running
}

class Game {
    let rows: Int
    let columns: Int
    let bombs: Int
    private(set) var board: Board!
    private(set) var state: GameState!
    
    init(rows: Int, columns: Int, bombs: Int) {
        self.rows = rows
        self.columns = columns
        self.bombs = bombs
    }
    
    func initializeGame() {
        self.board = Board(rows: rows, columns: columns, bombsNumber: self.bombs)
        self.state = .running
    }
    
    func start() {
        // Starts a new game
        self.initializeGame()
        self.playGame()
    }
    
    private func playGame() {
        // Captures the inputs and interface them with the board,
        // prints the board and keeps the game running
    }
    
    
}
