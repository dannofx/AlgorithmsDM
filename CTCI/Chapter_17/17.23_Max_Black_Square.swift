//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//
// Max Square Matrix

import Foundation

enum Color {
    case black
    case white
}

typealias Position = (row: Int, column: Int)
typealias BlackRange = (below: Int, right: Int)

func createBlackRanges(_ matrix: [[Color]]) -> [[BlackRange]] {
    let defaultRow = [BlackRange](repeating: (0, 0), count: matrix.count)
    var sizes = [[BlackRange]](repeating: defaultRow, count: matrix.count)
    for row in stride(from: (matrix.count - 1), through: 0, by: -1) {
        var rightCount = 0
        for column in stride(from: (matrix[row].count - 1), through: 0, by: -1) {
            if matrix[row][column] == .black {
                let isLastRow = row == (matrix.count - 1)
                let prevBelow = isLastRow ? 0 : sizes[row + 1][column].below
                rightCount += 1
                sizes[row][column].below = prevBelow + 1
                sizes[row][column].right = rightCount
            } else {
                rightCount = 0
                sizes[row][column].below = 0
                sizes[row][column].right = 0
            }
        }
    }
    return sizes
}

func isValidSubSquare(_ position: Position, blackRanges: [[BlackRange]], size: Int) -> Bool {
    return blackRanges[position.row][position.column].below >= size &&
        blackRanges[position.row][position.column].right >= size &&
        blackRanges[position.row + size - 1][position.column].right >= size &&
        blackRanges[position.row][position.column + size - 1].below >= size
    
}

func findSubSquare(withSize size: Int, blackRanges: [[BlackRange]]) -> Position? {
    for row in 0..<(blackRanges.count - (size - 1)) {
        for column in 0..<(blackRanges[row].count - (size - 1)) {
            let position = Position(row: row, column: column)
            if isValidSubSquare(position, blackRanges: blackRanges, size: size) {
                return position
            }
        }
    }
    return nil
}

func findMaxBlackSubSquare(matrix: [[Color]]) -> (position: Position, size: Int)? {
    let blackRanges = createBlackRanges(matrix)
    for size in stride(from: matrix.count, to: 0, by: -1) {
        if let subSquare = findSubSquare(withSize: size, blackRanges: blackRanges) {
            return (subSquare, size)
        }
    }
    return nil
}

let matrix: [[Color]] = [
    [.white, .white, .white, .black, .white, .white, .black, .black],
    [.white, .white, .white, .black, .white, .white, .black, .black],
    [.white, .white, .white, .white, .white, .white, .white, .white],
    [.white, .black, .black, .black, .black, .white, .white, .white],
    [.white, .black, .black, .white, .black, .black, .black, .black],
    [.white, .black, .white, .white, .black, .black, .black, .black],
    [.white, .black, .black, .black, .black, .black, .black, .black],
    [.white, .white, .white, .white, .white, .black, .black, .black]
]
if let maxSubSquare = findMaxBlackSubSquare(matrix: matrix) {
    print(maxSubSquare)
} else {
    print("Not subsquare found")
}
