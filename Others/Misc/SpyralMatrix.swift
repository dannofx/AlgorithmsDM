import Foundation
 
func printSpyral(matrix: [[Int]]) {
  var string = ""
  var left = 0
  var right = matrix[0].count - 1
  var top = 0
  var bottom = matrix.count - 1
  while left <= right && top <= bottom {
    for i in left..<right {
      string.append("\(matrix[top][i]),")
    }
    for i in top..<bottom {
      string.append("\(matrix[i][right]),")
    }
    for i in stride(from: right, to: left, by: -1) {
      string.append("\(matrix[bottom][i]),")
      if bottom == top {
        break
      }
    }    
    for i in stride(from: bottom, to: top, by: -1) {
      string.append("\(matrix[i][left]),")
      if right == left {
        break
      }
    }
    if left == right && top == bottom {
      string.append("\(matrix[top][left]),")
    }
    left += 1
    right -= 1
    top += 1
    bottom -= 1
  }
 
  print(string)
}
 
// let matrix = [
//               [1,2,3,4,5,6,7],
//               [1,2,3,4,5,6,7],              
//               [1,2,3,4,5,6,7],
//               [1,2,3,4,5,6,7],              
//               [1,2,3,4,5,6,7],
//               [1,2,3,4,5,6,7],
//               [1,2,3,4,5,6,7]
//             ]
// let matrix = [
//               [1,2,3,4],
//               [5,6,7,8],              
//               [9,10,11,12],
//               [13,14,15,16]
//             ]
 
// let matrix = [
//               [1,2,3,4,5],
//               [6,7,8,9,10],
//               [11,12,13,14,15]
//             ]
let matrix = [
              [1,2,3],
              [4,5,6],
              [7,8,9]
            ]
// let matrix = [
//               [1,2,3,4],
//               [5,6,7,8],
//               [9,10,11,12],
//               [13,14,15,16]
//             ]
           
 
printSpyral(matrix: matrix)