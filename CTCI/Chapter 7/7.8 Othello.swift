// Othello

import Foundation

enum Color {
    case white
    case black
}

struct Piece {
    var color: Color?
    
    init() {
        
    }
    
    init(color: Color) {
        self.color = color
    }
    
    mutating func flipColor() -> Color? {
        if let color = self.color {
            self.color = (color == .black ? .white : .black)
        }
        return self.color
    }
}

class Board {
    private var blackCount: Int
    private var whiteCount: Int
    private let board: [[Piece]]
    
    init(rows: Int, columns: Int) {
        self.blackCount = 0
        self.whiteCount = 0
        // Should contain at least four initial pieces set with a color
        self.board = [[Piece]](repeating: [Piece](repeating: Piece(), count: columns), count: rows)
    }
    
    func placeColor(color: Color, row: Int, column: Int) -> Bool {
        if row >= self.board.count {
            return false
        }
        if column >= self.board[row].count {
            return false
        }
        var piece = self.board[row][column]
        if piece.color == nil {
            piece.color = color
            return true
        } else {
            return false
        }
    }
    
    func getScore(forColor color: Color) -> Int{
        return color == .black ? blackCount : whiteCount
    }
    
    func updateScore(newColor: Color, piecesNumber: Int) {
        //Update board with additional piecesNumber of color newColor.
        // Decrease the score of the opposite color.
    }
}

class Player {
    let color: Color
    
    init(color: Color) {
        self.color = color
    }
    
    var score: Int {
        return Game.game.board.getScore(forColor: self.color)
    }
    
    func playPiece(row: Int, column: Int) -> Bool {
        return Game.game.playPiece(player: self, row: row, column: column)
    }
}

class Game {
    let players: [Player]
    let board: Board
    let rows = 10
    let columns = 10
    static let game: Game = {
        return Game()
    }()
    
    
    private init() {
        self.board = Board(rows: rows, columns: columns)
        self.players = [Player(color: .black), Player(color: .white)]
    }
    
    func playPiece(player: Player, row: Int, column: Int) -> Bool {
        // Play the a piece for the player
        // and manages the pieces that need to
        // be flipped as a consequence.
        // Also updates the board
        return false
    }
}
