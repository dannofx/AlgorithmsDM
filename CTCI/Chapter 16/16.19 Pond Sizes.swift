// Pond Sizes

import Foundation

func countPondSize(land: [[Int]], visited: inout [[Bool]], index: (row: Int, column: Int)) -> Int? {
    if index.row < 0 || index.row >= land.count ||
        index.column < 0 || index.column >= land[0].count ||
        land[index.row][index.column] != 0 ||
        visited[index.row][index.column] {
        return nil
    }
    var size = 1
    visited[index.row][index.column] = true
    for rDelta in -1...1 {
        for cDelta in -1...1 {
            if let subSize = countPondSize(land: land,
                                         visited: &visited,
                                         index: (index.row + rDelta, index.column + cDelta)) {
                size += subSize
            }
        }
    }
    return  size
}

func countPondSizes(land: [[Int]]) -> [Int] {
    precondition(land.count > 0)
    var sizes = [Int]()
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: land[0].count), count: land.count)
    let width = land[0].count
    for row in 0..<land.count {
        precondition(land[row].count == width)
        for column in 0..<land[row].count {
            if let size = countPondSize(land: land, visited: &visited, index: (row, column)) {
                sizes.append(size)
            }
        }
    }
    return sizes
}

let land = [
            [0, 2, 1, 0],
            [0, 1, 0, 1],
            [1, 1, 0, 1],
            [0, 1, 0, 1]
            ]
let pondSizes = countPondSizes(land: land)
print("Pond sizes in land: \(pondSizes)")

