// Langton's Ant

import Foundation

// MARK: - Orientation structure

enum Orientation {
    case right
    case left
    case up
    case down
    
    var stringValue: String {
        switch self {
        case .right:
            return "➡️"
        case .left:
            return "⬅️"
        case .up:
            return "⬆️"
        case .down:
            return "⬇️"
        }
    }
}

// MARK: - Position structure

struct Position: Hashable {
    let row: Int
    let column: Int
    
    var hashValue: Int {
        return row ^ column
    }
    
    static func ==(lhs: Position, rhs: Position) -> Bool{
        return lhs.column == rhs.column && lhs.row == rhs.row
    }
}

// MARK: - Board class

class Board {
    private(set) var ant: Ant
    private var whites: Set<Position>
    private var topLeftPos: Position
    private var bottomRightPos: Position
    
    init() {
        let origin = Position(row: 0, column: 0)
        self.ant = Ant(position: origin, orientation: .right)
        self.whites = Set<Position>()
        self.topLeftPos = origin
        self.bottomRightPos = origin
    }
    
    func move() {
        self.ant.turn(self.isWhite(self.ant.position))
        self.flip(position: self.ant.position)
        self.ant.move()
        self.checkBoardSize(forPosition: self.ant.position)
    }
    
    func isWhite(_ position: Position) -> Bool{
        return self.whites.contains(position)
    }
    
    var stringValue: String {
        var representation = ""
        for row in (self.topLeftPos.row...self.bottomRightPos.row) {
            for column in (self.topLeftPos.column...self.bottomRightPos.column) {
                let position = Position(row: row, column: column)
                if self.ant.position == position {
                    representation.append(self.ant.orientation.stringValue)
                } else {
                    representation.append(self.getStringValue(forPosition: position))
                }
            }
            representation.append("\n")
        }
        representation.append("Ant's position color: \(self.getStringValue(forPosition: self.ant.position)) \n")
        return representation
    }
    
    private func getStringValue(forPosition position: Position) -> String {
        if self.whites.contains(position) {
            return "⚪️"
        } else {
            return "⚫️"
        }
    }
    
    private func flip(position: Position) {
        if self.whites.contains(position) {
            self.whites.remove(position)
        } else {
            self.whites.insert(position)
        }
    }
    
    private func checkBoardSize(forPosition position: Position) {
        var newTopRow = self.topLeftPos.row
        var newLeftColumn = self.topLeftPos.column
        var newBottomRow = self.bottomRightPos.row
        var newRightColumn = self.bottomRightPos.column
        if position.column < self.topLeftPos.column {
            newLeftColumn = position.column
        }
        if position.row < self.topLeftPos.row {
            newTopRow = position.row
        }
        if position.column > self.bottomRightPos.column {
            newRightColumn = position.column
        }
        if position.row > self.bottomRightPos.row {
            newBottomRow = position.row
        }
        self.topLeftPos = Position(row: newTopRow, column: newLeftColumn)
        self.bottomRightPos = Position(row: newBottomRow, column: newRightColumn)
    }
}

// MARK: - Ant class

class Ant {
    private(set) var position: Position
    private(set) var orientation: Orientation
    
    init(position: Position, orientation: Orientation) {
        self.position = position
        self.orientation = orientation
    }
    
    func turn(_ clockWise: Bool) {
        var newOrientation: Orientation!
        switch self.orientation {
        case .right:
            newOrientation = clockWise ? .down : .up
        case .down:
            newOrientation = clockWise ? .left : .right
        case .left:
            newOrientation = clockWise ? .up : .down
        case .up:
            newOrientation = clockWise ? .right : .left
        }
        self.orientation = newOrientation
    }
    
    func move() {
        var row = self.position.row
        var column = self.position.column
        switch self.orientation {
        case .right:
            column += 1
        case .down:
            row += 1
        case .left:
            column -= 1
        case .up:
            row -= 1
        }
        self.position = Position(row: row, column: column)
    }
}

// MARK: - Test

let board = Board()
let k = 100
for _ in 0..<k {
    board.move()
}
print("Board state after \(k) movements:")
print(board.stringValue)
