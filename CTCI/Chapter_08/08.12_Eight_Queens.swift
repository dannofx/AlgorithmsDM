//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Eight Queens

import Foundation

let boardSize = 8

func placeQueen(row: Int, columns: inout [Int], results: inout [[Int]]) {
    if row >= columns.count {
        results.append(columns)
    }
    
    for i in 0..<columns.count {
        if isValidPosition(row: row, column: i, columns: columns) {
            columns[row] = i
            placeQueen(row: row + 1, columns: &columns, results: &results)
        }
    }
}

func isValidPosition(row: Int, column: Int, columns: [Int]) -> Bool {
    for otherRow in 0..<row {
        let otherColumn = columns[otherRow]
        if column == otherColumn { // Check if they are in the same column
            return false
        }
        if (row - otherRow) == abs(column - otherColumn) { // Check if they are in the same diagonal
            return false
        }
    }
    return true
}
func calculateQueensArrangements() -> [[Int]] {
    var columns = [Int](repeating: -1, count: boardSize)
    var results = [[Int]]()
    placeQueen(row: 0, columns: &columns, results: &results)
    return results
}

print("Queen arrangements for a board of size \(boardSize):")
let arrangements = calculateQueensArrangements()
for arrangement in arrangements {
    print(arrangement)
}

