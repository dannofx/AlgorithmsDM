// Letters and numbers

import Foundation

extension Character {
    var isNumber: Bool {
        return "0"..."9" ~= self
    }
}

func calculateDifferences(array: [Character]) -> [Int] {
    var letters = 0
    var numbers = 0
    var counts = [Int]()
    for char in array {
        if char.isNumber {
            numbers += 1
        } else {
            letters += 1
        }
        counts.append(numbers - letters)
    }
    return counts
}

func findLongestMatchRange(deltas: [Int]) -> (start: Int, end: Int)? {
    var deltasDict = [Int: Int]() // [Delta: Index]
    deltasDict[0] = -1 // In case there are just 2 elements
    var longestRange = (start: 0, end: 0)
    for i in 0..<deltas.count {
        let delta = deltas[i]
        if let foundIndex = deltasDict[delta] {
            let currentDistance = i - foundIndex
            let maxDistance = longestRange.end - longestRange.start
            if  currentDistance > maxDistance {
                longestRange.start = foundIndex
                longestRange.end = i
            }
        } else {
            deltasDict[delta] = i
        }
    }
    return longestRange.end == -1 ? nil : longestRange
}

func findLongestSubArray(array: [Character]) -> [Character]? {
    let deltas = calculateDifferences(array: array)
    if let range = findLongestMatchRange(deltas: deltas) {
        return Array(array[(range.start + 1)...range.end])
    } else {
        return nil
    }
}

let array: [Character] = ["8","d","8","3","j","4","h","5","7","s","7","1","2","h","9","3","8","4","7","f","7","4","s","s","6","2","8","h","j","6"]
print("Original array: ")
print(array)
if let subarray = findLongestSubArray(array: array) {
    print("Longest subarray with same number of letters and numbers:")
    print(subarray)
} else {
    print("Error: The array just have one type of element")
}
