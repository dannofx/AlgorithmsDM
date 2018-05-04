//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Rotate Matrix

import Foundation

extension Array where Element == Array<Int> {
    
    mutating func swapInCycle(_ positions: [(row: Int, column: Int)]) {
        if positions.count <= 1 {
            return
        }
        var sub = self[positions[0].row][positions[0].column]
        for i in 1..<positions.count {
            let pos = positions[i]
            let tmp = self[pos.row][pos.column]
            self[pos.row][pos.column] = sub
            sub = tmp
        }
        self[positions[0].row][positions[0].column] = sub
    }
    
    var isSquare: Bool {
        let n = self.count
        for vector in self {
            if vector.count != n {
                return false
            }
        }
        return true
    }
}

func rotateMatrix(_ matrix: inout [[Int]]) {
    precondition(matrix.isSquare, "Error: Not an square matrix.")
    var left = 0
    while left < (matrix.count / 2) {
        let right = matrix[0].count - left - 1
        let top = left
        let bottom = right
        for i in left..<right {
            var indexes = [(row: Int, column: Int)]()
            let j = right - (i - left)
            indexes.append((top, i))
            indexes.append((i, right))
            indexes.append((bottom, j))
            indexes.append((j, left))
            matrix.swapInCycle(indexes)
        }
        left += 1
    }
}


//var matrix =    [[1,2,3],
//                [4,5,6],
//                [7,8,9]]
//var matrix = [[1,2,3,4],
//              [5,6,7,8],
//              [9,10,11,12],
//              [13,14,15,16]]
var matrix = [[1,2,3,4,5],
              [6,7,8,9,10],
              [11,12,13,14,15],
              [16,17,18,19,20],
              [21,22,23,24,25]]

print("Input matrix:")
for vector in matrix {
    print("\(vector)")
}
rotateMatrix(&matrix)
print("Rotated matrix:")
for vector in matrix {
    print("\(vector)")
}
