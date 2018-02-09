// Tic Tac Win

import Foundation

enum Piece {
    case cross
    case circle
    case empty
}

class PieceIterator: IteratorProtocol {
    typealias Element = Piece
    private let board: [[Piece]]
    private let increment: (x: Int, y: Int)
    private var position: (x: Int, y: Int)
    
    init(board: [[Piece]], increment:(x: Int, y: Int), start: (x: Int, y: Int)) {
        precondition(increment.x != 0 || increment.y != 0)
        self.board = board
        self.increment = increment
        self.position = start
    }
    
    private var isInBounds: Bool {
        return self.position.x >= 0 && self.position.y >= 0 &&
                self.position.x < self.board[0].count && self.position.y < self.board.count
    }
    
    func next() -> Piece? {
        if self.isInBounds {
            let piece = self.board[self.position.y][self.position.x]
            self.position.x += self.increment.x
            self.position.y += self.increment.y
            return piece
        } else {
            return nil
        }
    }
}

func getWinner(iterator: PieceIterator) -> Piece {
    guard let compPiece = iterator.next(), compPiece != .empty else{
        return .empty
    }
    while let piece = iterator.next() {
        if piece != compPiece {
            return .empty
        }
    }
    return compPiece
}

func getWinner(board: [[Piece]]) -> Piece {
    precondition(board.count > 0)
    precondition(board[0].count == board.count) // Check rest of the rows?
    var iterators = [PieceIterator]()
    for i in 0..<board.count {
        iterators.append(PieceIterator(board: board, increment: (x: 0, y: 1), start: (x: i, y: 0)))
        iterators.append(PieceIterator(board: board, increment: (x: 1, y: 0), start: (x: 0, y: i)))
    }
    iterators.append(PieceIterator(board: board, increment: (x: 1, y: 1), start: (x: 0, y: 0)))
    iterators.append(PieceIterator(board: board, increment: (x: 1, y: -1), start: (x: 0, y: board.count - 1)))
    for iterator in iterators {
        let piece = getWinner(iterator: iterator)
        if piece != .empty {
            return piece
        }
    }
    return .empty
}

let board: [[Piece]] = [
                        [.empty, .circle, .cross],
                        [.empty, .empty, .cross],
                        [.cross, .circle, .cross]
                    ]
let winner = getWinner(board: board)
if winner != .empty {
    print("Winner: \(winner)")
} else {
    print("No winner")
}

