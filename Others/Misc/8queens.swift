import Foundation

import Foundation

let boardSize = 4

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

// Mi solución con flojera

func isValid(_ index: Int, _ pos: [Int]) -> Bool {
  for i in 0..<index {
    let diag1 = pos[i] + (index - i)
    let diag2 = pos[i] - (index - i)
    if diag1 == pos[index] || diag2 == pos[index] {
      return false
    }
  }
  return true
}

func posQueen(pos: inout [Int], index: Int) {
  if pos.count == index {
    print("sale")
    print(pos)
    return
  }
  for i in index..<pos.count {
    pos.swapAt(i, index)
    if isValid(index, pos) {
      posQueen(pos: &pos, index: index + 1)
    }
    pos.swapAt(i, index)
  }

}

func posQueens(n: Int) {
  var pos = [Int](0..<n)
  posQueen(pos: &pos, index: 0)
}
posQueens(n: boardSize)
print("Queen arrangements for a board of size \(boardSize):")
let arrangements = calculateQueensArrangements()
for arrangement in arrangements {
    print(arrangement)
}