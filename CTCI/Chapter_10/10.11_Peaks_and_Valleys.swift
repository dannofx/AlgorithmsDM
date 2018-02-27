//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Peaks and Valleys

import Foundation

func maxIndex(array: [Int], a: Int, b: Int, c: Int) -> Int {
    let aVal = a >= 0 && a < array.count ? array[a] : Int.min
    let bVal = b >= 0 && b < array.count ? array[b] : Int.min
    let cVal = c >= 0 && c < array.count ? array[c] : Int.min
    let maxVal = max(aVal, bVal, cVal)
    switch maxVal {
    case aVal:
        return a
    case bVal:
        return b
    default:
        return c
    }
}

func swap(array: inout [Int], a: Int, b: Int) {
    if a < 0 || a >= array.count || b < 0 || b >= array.count {
        return
    }
    let tmp = array[a]
    array[a] = array[b]
    array[b] = tmp
}

func sortPeaksAndValleys(array: inout [Int]) {
    for i in stride(from: 1, to: array.count, by: 2) {
        let max = maxIndex(array: array, a: i - 1, b: i, c: i + 1)
        if i != max {
            swap(array: &array, a: i, b: max)
        }
    }
}

var numbers = [5,3,1,2,3]
sortPeaksAndValleys(array: &numbers)
print("Sorted by peaks and vallyes: \(numbers)")