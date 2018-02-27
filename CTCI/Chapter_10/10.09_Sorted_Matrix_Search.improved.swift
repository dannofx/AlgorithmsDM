// Sorted Matrix Search

import Foundation



struct Coordinate {
    var row: Int
    var column: Int
    
    init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
    
    init(min: Coordinate, max: Coordinate) {
        self.row = min.row + (max.row - min.row) / 2
        self.column = min.column + (max.column - min.column) / 2
    }
    
    func inBounds(_ matrix: [[Int]]) -> Bool {
        return self.row >= 0 && self.column >= 0 &&
               self.row < matrix.count && self.column < matrix[0].count
    }
    
    func isBefore(_ coordinate: Coordinate) -> Bool{
        return self.row <= coordinate.row && self.column <= coordinate.column
    }

}

func partitionateAndFind(value: Int, matrix: [[Int]], origin: Coordinate, pivot: Coordinate, destiny: Coordinate) -> Coordinate? {
    let lowerLeftOrigin = Coordinate(row: pivot.row, column: origin.column)
    let lowerLeftDestiny = Coordinate(row:destiny.row, column: pivot.column - 1)
    let upperRightOrigin = Coordinate(row: origin.row, column: pivot.column)
    let upperRightDestiny = Coordinate(row: pivot.row - 1, column: destiny.column)
    if let elementCoordinate = find(value: value, matrix: matrix, origin: lowerLeftOrigin, destiny: lowerLeftDestiny) {
        return elementCoordinate
    } else {
        return find(value: value, matrix: matrix, origin: upperRightOrigin, destiny: upperRightDestiny)
    }
}

func find(value: Int, matrix: [[Int]], origin: Coordinate, destiny: Coordinate) -> Coordinate? {
    if !origin.inBounds(matrix) || !destiny.inBounds(matrix) {
        return nil
    }
    if matrix[origin.row][origin.column] == value {
        return origin
    } else if !origin.isBefore(destiny) {
        return nil
    }
    // Find start and end points or the diagonal
    var start = origin
    let diagonalSize = min(destiny.row - origin.row, destiny.column - origin.column)
    var end = Coordinate(row: start.row + diagonalSize, column: start.column + diagonalSize)
    // Do binary search
    while start.isBefore(end) {
        let middle = Coordinate(min: start, max: end)
        if matrix[middle.row][middle.column] == value {
            return middle
        } else if matrix[middle.row][middle.column] < value {
            start.row = middle.row + 1
            start.column = middle.column + 1
        } else {
            end.row = middle.row - 1
            end.column = middle.column - 1
        }
    }
    return partitionateAndFind(value: value, matrix: matrix, origin: origin, pivot: start, destiny: destiny)
}

func findCoordinate(value: Int, matrix: [[Int]]) -> Coordinate? {
    if matrix.count == 0 || matrix[0].count == 0 {
        return nil
    }
    let origin = Coordinate(row: 0, column: 0)
    let destiny = Coordinate(row: matrix.count - 1, column: matrix[0].count - 1)
    return find(value: value, matrix: matrix, origin: origin, destiny: destiny)
}

let sortedMatrix = [
                    [01,02,03,04,05],
                    [06,07,08,09,10],
                    [11,12,13,14,15],
                    [16,17,18,19,20],
                    [21,22,23,24,25]
                   ]

let number = 21
if let coordinate = findCoordinate(value: number, matrix: sortedMatrix) {
    print("Index found for \(number): (row: \(coordinate.row), column:\(coordinate.column))")
} else {
    print("Index not found for \(number)")
}



