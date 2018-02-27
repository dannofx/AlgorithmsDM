// Rotate Matrix

import Foundation

func swapElements(_ positions: [(x: Int, y: Int)], _ matrix: inout [[Int]]) {
    if positions.count <= 1 {
        return
    }
    let temp = matrix[positions.first!.x][positions.first!.y]
    for i in 0..<(positions.count - 1) {
        let position = positions[i]
        let nextPosition = positions[i + 1]
        matrix[position.x][position.y] = matrix[nextPosition.x][nextPosition.y]
    }
    matrix[positions.last!.x][positions.last!.y] = temp
}

func rotateMatrix(_ matrix: inout [[Int]]) {
    let n = matrix.count
    if n <= 1 {
        print("Error: There are not enough elements to rotate the matrix")
        return
    }
    for vector in matrix {
        if vector.count != n {
            print("Error: The input is not an squared matrix")
            return
        }
    }
    for level in 0..<( n / 2 ) {
        for i in level..<( n - level - 1 ) {
            let lastIndex = n - 1
            let p1 = (level + i, level)
            let p2 = (-level + lastIndex, level + i)
            let p3 = (-level + lastIndex - i, -level + lastIndex)
            let p4 = (level, -level + lastIndex - i)
            let swapPositions = [p1, p2, p3, p4]
            swapElements(swapPositions, &matrix)
        }
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
