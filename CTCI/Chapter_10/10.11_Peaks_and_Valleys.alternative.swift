//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Peaks and Valleys

// Alternative version of the problem where a peak is considered a peak
// if and only if it's greater than the adjacent elements and valley is
// considered a valley if and only if it's lower than the adjacent elements.

import Foundation

func sortPeaksAndValleys(array: [Int]) -> [Int]? {
    var sorted = array.sorted()
    if sorted.count <= 1 {
        return sorted
    }
    if sorted.count == 2 {
        return sorted[0] != sorted[1] ? sorted : nil
    }
    let middle = sorted.count / 2
    if sorted[middle] == sorted[middle - 1] && sorted[middle] == sorted[middle + 1] {
        return nil
    }
    var result = [Int]()
    let leftOrientation = sorted[middle] == sorted[middle - 1]
    var i = 0
    while result.count != sorted.count {
        let a = i
        let b = sorted.count - 1 - i
        if leftOrientation {
            result.append(sorted[a])
            if a != b {
                result.append(sorted[b])
            }
        } else {
            result.append(sorted[b])
            if a != b {
                result.append(sorted[a])
            }
        }
        i += 1
    }
    return result
}

let numbers = [0,3,1,2,3,3]
if let peaksAndValleys = sortPeaksAndValleys(array: numbers) {
    print("Sorted by peaks and vallyes: \(peaksAndValleys)")
} else {
    print("The array can't be sorted")
}
