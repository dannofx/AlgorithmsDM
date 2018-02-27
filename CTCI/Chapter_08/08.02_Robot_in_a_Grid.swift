// Robot in a Grid
import Foundation

struct Position: Hashable {
    var row: Int
    var column: Int
    
    var hashValue: Int {
        return self.row.hashValue - self.column.hashValue
    }
    
    static func == (lhs: Position, rhs: Position) -> Bool {
        return lhs == rhs
    }
}

func findPath(current: Position, matrix: [[Bool]], path: inout [Position], failed: inout Set<Position>) -> Bool{
    if current.row < 0 || current.column < 0 || !matrix[current.row][current.column] {
        return false
    }
    if failed.contains(current) {
        return false
    }
    let nextRow = current.row - 1
    let nextColumn = current.column - 1
    if (current.row == 0 && current.column == 0 ) ||
        findPath(current: Position(row: nextRow, column: nextColumn), matrix: matrix, path: &path, failed: &failed) ||
        findPath(current: Position(row: nextRow, column: current.column), matrix: matrix, path: &path, failed: &failed) ||
        findPath(current: Position(row: current.row, column: nextColumn), matrix: matrix, path: &path, failed: &failed) {
        path.append(current)
        return true
    }
    failed.insert(current)
    return false
}

func findRobotPath(rows: Int, columns: Int, obstacles: [Position]) -> [Position]? {
    if rows <= 0 || columns <= 0 {
        return nil
    }
    var matrix = [[Bool]](repeating: [Bool](repeating: true, count: columns), count: rows)
    for obstacle in obstacles {
        if obstacle.row < 0 || obstacle.row >= rows ||
            obstacle.column < 0 || obstacle.column >= columns {
            return nil
        }
        matrix[obstacle.row][obstacle.column] = false
    }

    var path = [Position]()
    var failed = Set<Position>()
    if findPath(current: Position(row: rows - 1, column: columns - 1), matrix: matrix, path: &path, failed: &failed) {
        return path
    } else {
        return nil
    }
}

let rows = 10
let columns = 10
let obstacles = [Position(row: 7, column: 7)]
if let path = findRobotPath(rows: rows, columns: columns, obstacles: obstacles) {
    print("Robot path:")
    for step in path {
        print(step)
    }
} else {
    print("Path not found")
}



