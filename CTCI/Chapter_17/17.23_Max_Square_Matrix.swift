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

typealias SubSquare = (row: Int, column: Int, size: Int)
typealias BlackRange = (blacksRight: Int, blacksBelow: Int)


func processBlackRanges(matrix: [[Color]]) -> [[BlackRange]] {
    // Initialize ranges with zeroes
    let defaultRow = [BlackRange](repeating: (0, 0), count: matrix[0].count)
    var ranges = [[BlackRange]](repeating: defaultRow,
                                    count: matrix.count)
    for row in stride(from: matrix.count - 1, through: 0, by: -1) {
        var blacksRight = 0
        for column in stride(from: matrix[0].count - 1, through: 0, by: -1) {
            // Get the black cells below the current position
            var blacksBelow = 0
            if matrix[row][column] == .black {
                if row < (matrix.count - 1) && matrix[row + 1][column] == .black {
                    blacksBelow = ranges[row + 1][column].blacksBelow
                }
                blacksBelow += 1
            }
            // Increments or resets blacksRight
            // depending of the current color
            if matrix[row][column] == .black {
                blacksRight += 1
            } else {
                blacksRight = 0
            }
            // Set the sizes
            ranges[row][column] = BlackRange(blacksRight: blacksRight, blacksBelow: blacksBelow)
        }
    }
    return ranges
}

func isValidSquare(blackRanges: [[BlackRange]], row: Int, column: Int, size: Int) -> Bool {
    let topLeft = blackRanges[row][column]
    let topRight = blackRanges[row][column + size - 1]
    let bottomLeft = blackRanges[row + size - 1][column]
    return topLeft.blacksBelow >= size &&
           topLeft.blacksRight >= size &&
           topRight.blacksBelow >= size &&
           bottomLeft.blacksRight >= size
}

func findBlackSubSquare(blackRanges: [[BlackRange]], size: Int) -> SubSquare? {
    let rowLimit = blackRanges.count - size
    let columnLimit = blackRanges[0].count - size
    for row in 0...rowLimit {
        for column in 0...columnLimit {
            let valid = isValidSquare(blackRanges: blackRanges,
                                      row: row,
                                      column: column,
                                      size: size)
            if valid {
                return SubSquare(row: row, column: column, size: size)
            }
        }
    }
    return nil
}

func findBlackSubSquare(matrix: [[Color]]) -> SubSquare? {
    precondition(matrix.count > 0)
    precondition(matrix[0].count == matrix.count)
    let blackRanges = processBlackRanges(matrix: matrix)
    for size in stride(from: matrix.count - 1, through: 1, by: -1) {
        if let subSquare = findBlackSubSquare(blackRanges: blackRanges, size: size) {
            return subSquare
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

// Biggest in (row: 3, column: 1, size: 4)

if let subSquare = findBlackSubSquare(matrix: matrix) {
    print("Biggest subsquare found: \(subSquare)")
} else {
    print("Error: No subsquare found")
}

