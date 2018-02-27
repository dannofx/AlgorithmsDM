//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Sparce Search

import Foundation

func findClosesNonEmpty(middle: Int, array: [String], first: Int, last: Int) -> Int? {
    for i in stride(from: middle, through: first, by: -1) {
        if array[i] != "" {
            return i
        }
    }
    for i in middle...last {
        if array[i] != "" {
            return i
        }
    }
    return nil
}

func find(value: String, in array: [String], first: Int, last: Int) -> Int? {
    if first > last {
        return nil
    }
    let unMiddle = first + (last - first) / 2
    guard let middle = findClosesNonEmpty(middle: unMiddle, array: array, first: first, last: last) else {
        return nil
    }
    if array[middle] == value {
        return middle
    } else if array[middle] > value {
        return find(value: value, in: array, first: first, last: middle - 1)
    } else {
        return find(value: value, in: array, first: middle + 1, last: last)
    }
}

func find(value: String, in array: [String]) -> Int? {
    if value == "" {
        return nil
    } else {
        return find(value: value, in: array, first: 0, last: array.count - 1)
    }
}

let words = ["aa", "", "", "", "bb", "", "cc", "dd", "", "", "", "ee", "", "", "", "ff", "", "gg", "hh", "", "", "", ""]
let searchWord = "ff"
if let index = find(value: searchWord, in: words) {
    print("Index for work \"\(searchWord)\": \(index)")
} else {
    print("Error: Index not found for word \"\(searchWord)\"")
}
