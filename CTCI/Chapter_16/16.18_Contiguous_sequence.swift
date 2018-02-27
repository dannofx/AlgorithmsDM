//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Contiguous sequence

import Foundation

let aChar: Character = "a"
let bChar: Character = "b"

extension String {
    subscript(i: Int) -> Character {
        get {
            let index = self.index(self.startIndex, offsetBy: i)
            return self[index]
        }
    }
    
    func intIndex(of char: Character) -> Int? {
        if let index = self.index(of: char) {
            return self.distance(from: self.startIndex, to: index)
        } else {
            return nil
        }
    }
    
    func countChar(_ character: Character) -> Int {
        var count = 0
        for current in self {
            if character == current {
                count += 1
            }
        }
        return count
    }
    
    func matchSubstrings(index1: Int, index2: Int, size: Int) -> Bool {
        precondition(size >= 0)
        if (index1 < 0 || index1 >= self.count) ||
            (index2 < 0 || index2 >= self.count) {
            return false
        }
        let start = min(index1, index2)
        let offset = max(index1, index2) - start
        for i in start..<(start + size) {
            let j = offset + i
            if j >= self.count || self[i] != self[j] {
                return false
            }
        }
        return true
    }
}



func match(pattern: String, value: String, firstSize: Int, secondSize: Int, secondIndex: Int) -> Bool {
    precondition(pattern[0] == aChar || pattern[0] == bChar)
    var firstCount = 1
    var secondCount = 0
    for i in 1..<pattern.count {
        precondition(pattern[i] == aChar || pattern[i] == bChar)
        let size = pattern[i] == pattern[0] ? firstSize : secondSize
        let index1 = pattern[i] == pattern[0] ? 0 : secondIndex
        let index2 = (firstCount * firstSize + secondCount * secondSize)
        if !value.matchSubstrings(index1: index1, index2: index2, size: size) {
            return false
        }
        if pattern[i] == pattern[0] {
            firstCount += 1
        } else {
            secondCount += 1
        }
    }
    let end = (firstCount * firstSize + secondCount * secondSize)
    return end == value.count
}

func match(pattern: String, value: String) -> Bool {
    if pattern.count == 0 {
        return value.count == 0
    }
    let firstChar = pattern[0]
    let secondChar: Character = firstChar == aChar ? bChar : aChar
    let startSecond = pattern.intIndex(of: secondChar) ?? 0
    let firstCount = pattern.countChar(firstChar)
    let secondCount = pattern.count - firstCount
    let maxFirstSize = value.count / firstCount
    for firstSize in 0...maxFirstSize {
        let remainingSize = value.count - firstCount * firstSize
        if secondCount == 0 || (remainingSize % secondCount) == 0 {
            let secondSize = secondCount == 0 ? 0 : remainingSize / secondCount
            let secondIndex = firstSize * startSecond
            let doesMatch = match(pattern: pattern,
                                  value: value,
                                  firstSize: firstSize,
                                  secondSize: secondSize,
                                  secondIndex: secondIndex)
            if  doesMatch {
                return true
            }
        }
    }
    return false
}

let pattern = "aabab"
let value = "catcatgocatgo"
print("\"\(value)\" matches pattern \"\(pattern)\": \(match(pattern: pattern, value: value))")

