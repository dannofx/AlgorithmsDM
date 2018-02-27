//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Zero Matrix

import Foundation

func zeroMatrix(_ matrix: inout [[Int]]) {
    if matrix.count < 1 {
        print("Error: The matrix doesn't have any element.")
        return
    }
    let width = matrix[0].count
    // We will use the first row and column as indicators to save space,
    // so we need to know if these originally contained a zero
    var firstRowHasZeroes = false
    var firstColumnHasZeroes = false
    for elem in matrix[0] {
        if elem == 0 {
            firstRowHasZeroes = true
            break
        }
    }
    for vector in matrix {
        if vector.count != width {
            print("Error: this is not a rectangular matrix")
            return
        }
        if vector[0] == 0 {
            firstColumnHasZeroes = true
            break
        }
    }
    // Detect any zero inside of the matrix
    for row in 1..<matrix.count {
        for column in 1..<matrix[0].count {
            if matrix[column][row] == 0 {
                matrix[row][0] = 0
                matrix[0][column] = 0
            }
        }
    }
    
    // According to the values in the vectors
    // used as indicators (first row and column)
    // nullify the corresponding columns and
    // rows
    for i in 0..<matrix[0].count {
        if matrix[0][i] == 0 {
            for j in 0..<matrix.count {
                matrix[j][i] = 0
            }
        }
    }
    for j in 0..<matrix.count {
        if matrix[j][0] == 0 {
            for i in 0..<matrix[j].count {
                matrix[j][i] = 0
            }
        }
    }
    
    // According to the original state of the first column and row
    // nullify if necessary
    if firstRowHasZeroes {
        for i in 0..<matrix[0].count {
            matrix[0][i] = 0
        }
    }
    if firstColumnHasZeroes {
        for j in 0..<matrix.count {
            matrix[j][0] = 0
        }
    }
}


var matrix = [[1,2,3,0,5],
              [6,7,8,9,10],
              [11,12,0,14,15],
              [16,17,18,19,20],
              [21,22,23,24,25]]

print("Input matrix:")
for vector in matrix {
    print("\(vector)")
}
zeroMatrix(&matrix)
print("Zeroed matrix:")
for vector in matrix {
    print("\(vector)")
}
