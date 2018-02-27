//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Max Submatrix

import Foundation

typealias SubMatrix = (rowStart: Int, columnStart: Int, rowEnd: Int, columnEnd: Int, sum: Int)
typealias SubArray = (start: Int, end: Int, sum: Int)

func findMaxSubArray(array: [Int]) -> SubArray {
    var current = SubArray(start: 0, end: 0, sum: 0)
    var best = SubArray(start: -1, end: -1, sum: Int.min)
    for (i, value) in array.enumerated() {
        current.end = i
        current.sum += value
        if current.sum > best.sum {
            best.sum = current.sum
            best.end = i
            best.start = current.start
        }
        if current.sum < 0 {
            current.sum = 0
            current.start = i + 1
        }
    }
    print(best)
    return best
}

func findMaxSubMatrix(matrix: [[Int]]) -> SubMatrix {
    precondition(matrix.count > 0)
    let rowsCount = matrix.count
    let colsCount = matrix[0].count
    var bestSubMatrix = SubMatrix(rowStart: -1,
                                  columnStart: -1,
                                  rowEnd: -1,
                                  columnEnd: -1,
                                  sum: Int.min)
    for rowStart in 0..<rowsCount {
        var partialSums = [Int](repeating: 0, count: colsCount)
        for rowEnd in rowStart..<rowsCount {
            // Get the sum of every column from rowStart to rowEnd
            for column in 0..<colsCount {
                partialSums[column] += matrix[rowEnd][column]
            }
            // Get the range of sums of columns that get the max result
            let bestColRange = findMaxSubArray(array: partialSums)
            // Compare against current best
            let bestSum = bestSubMatrix.sum
            if bestColRange.sum > bestSum {
                bestSubMatrix.rowStart = rowStart
                bestSubMatrix.columnStart = bestColRange.start
                bestSubMatrix.rowEnd = rowEnd
                bestSubMatrix.columnEnd = bestColRange.end
                bestSubMatrix.sum = bestColRange.sum
            }
        }
    }
    return bestSubMatrix
}

let matrix = [
                [ 9, -8,  1,  3, -2],
                [-3,  7,  6, -2,  4],
                [ 6, -4, -4,  8, -7],
             ]
let maxSubMatrix = findMaxSubMatrix(matrix: matrix)
print("Max submatrix: \(maxSubMatrix)")
