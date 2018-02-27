// Sorted Matrix Search

import Foundation


func compare(element: Int, row: [Int]) -> ComparisonResult {
    if row.count == 0 {
        return .orderedAscending
    }
    if row[0] <= element && element <= row[row.count - 1] {
        return .orderedSame
    } else if row[0] > element {
        return .orderedAscending
    } else {
        return .orderedDescending
    }
}


func findRowIndex(for element: Int, matrix: [[Int]], first: Int, last: Int) -> Int? {
    if first > last {
        return nil
    }
    let middle = first + (last - first) / 2
    let result = compare(element: element, row: matrix[middle])
    if result == .orderedSame {
        return middle // agregar el binary
    } else if result == .orderedAscending {
        return findRowIndex(for: element, matrix: matrix, first: first, last: middle - 1)
    } else {
        return findRowIndex(for: element, matrix: matrix, first: middle + 1, last: last)
    }
    
}

func findIndex(for element: Int, row: [Int], first: Int, last: Int) -> Int?{
    if first > last {
        return nil
    }
    let middle = first + (last - first) / 2
    if row[middle] == element {
        return middle // agregar el binary
    } else if row[middle] > element {
        return findIndex(for: element, row: row, first: first, last: middle - 1)
    } else {
        return findIndex(for: element, row: row, first: middle + 1, last: last)
    }
}

func findIndex(for element: Int, matrix: [[Int]]) -> (Int, Int)? {
    if matrix.count == 0 {
        return nil
    }
    guard let rowIndex = findRowIndex(for: element, matrix: matrix, first: 0, last: matrix.count - 1) else {
        return nil
    }
    let row = matrix[rowIndex]
    if row.count == 0 {
        return nil
    }
    guard let columnIndex = findIndex(for: element, row: row, first: 0, last: row.count - 1) else {
        return nil
    }
    return (rowIndex, columnIndex)
}

let sortedMatrix = [
                    [01,02,03,04,05],
                    [06,07,08,09,10],
                    [11,12,13,14,15],
                    [16,17,18,19,20],
                    [21,22,23,24,25]
                   ]

let number = 19
if let index = findIndex(for: number, matrix: sortedMatrix) {
    print("Index found for \(number): (row: \(index.0), column:\(index.1))")
} else {
    print("Index not found for \(number)")
}



