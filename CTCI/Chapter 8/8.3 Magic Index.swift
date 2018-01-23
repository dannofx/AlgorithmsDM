// Magic Index

import Foundation

func findMagicIndex(start: Int, end: Int, items: [Int]) -> Int? {
    print("Checking \(start) \(end)")
    if end < start {
        return nil
    }
    let middle = (end + start) / 2
    if items[middle] == middle {
        return middle
    }
    let leftEnd = min(middle - 1, items[middle])
    if let magic = findMagicIndex(start: start, end: leftEnd, items: items) {
        return magic
    }
    let rightStart = max(middle + 1, items[middle])
    return findMagicIndex(start: rightStart, end: end, items: items)
}

func findMagicIndex(_ items: [Int]) -> Int? {
    return findMagicIndex(start: 0, end: items.count - 1, items: items)
}

let items = [-1,0,1,2,4,4,5,6,7,9,10,13,14]
if let magicIndex = findMagicIndex(items) {
    print("Magic index: \(magicIndex)")
} else {
    print("Magic index not found")
}
