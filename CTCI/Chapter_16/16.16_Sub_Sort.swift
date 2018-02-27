// Sub Sort

import Foundation

func findFirstUnsortedIndex(numbers: [Int]) -> Int? {
    for i in 1..<numbers.count {
        if numbers[i] < numbers[i - 1] {
            return i - 1
        }
    }
    return nil
}

func findLastUnsortedIndex(numbers: [Int]) -> Int? {
    for i in stride(from: numbers.count - 2, through: 0, by: -1) {
        if numbers[i] > numbers[i + 1] {
            return i + 1
        }
    }
    return nil
}

func findMinIndex(numbers: [Int], end: Int, max: Int) -> Int {
    for i in stride(from: end - 1, through: 0, by: -1) {
        if numbers[i] <= max {
            return i + 1
        }
    }
    return 0
}

func findMaxIndex(numbers: [Int], start: Int, min: Int) -> Int {
    for i in (start + 1)..<numbers.count {
        if min <= numbers[i] {
            return i - 1
        }
    }
    return numbers.count - 1
}

func findUnsortedRange(numbers: [Int]) -> (start: Int, end: Int)? {
    precondition(numbers.count > 0)
    if numbers.count == 1 {
        return nil
    }
    guard var firstIndex = findFirstUnsortedIndex(numbers: numbers) else {
        return nil
    }
    var lastIndex = findLastUnsortedIndex(numbers: numbers)!
    var unsortedMin = Int.max
    var unsortedMax = Int.min
    for i in firstIndex...lastIndex {
        if unsortedMin > numbers[i] {
            unsortedMin = numbers[i]
        }
        if unsortedMax < numbers[i] {
            unsortedMax = numbers[i]
        }
    }
    firstIndex = findMinIndex(numbers: numbers, end: firstIndex, max: unsortedMin)
    lastIndex = findMaxIndex(numbers: numbers, start: lastIndex, min: unsortedMax)
    return (firstIndex, lastIndex)
}

let numbers = [1, 2, 4, 7, 10, 11, 7, 12, 6, 7, 16, 18, 19]
print("Numbers: \(numbers)")
if let unsortedRange = findUnsortedRange(numbers: numbers) {
    print("Unsorted range: (start:\(unsortedRange.start), end:\(unsortedRange.end))")
} else {
    print("Array is already sorted")
}
