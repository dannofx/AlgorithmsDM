// Word Distance

import Foundation

func createPositionsMap(_ words: [String]) -> [String: [Int]] {
    var map = [String: [Int]]()
    for i in 0..<words.count {
        let word = words[i]
        if map[word] == nil {
            map[word] = [Int]()
        }
        map[word]!.append(i)
    }
    return map
}

func findClosestPair(word1: String, word2: String, map: [String: [Int]]) -> (word1: Int, word2: Int)? {
    guard let positions1 = map[word1] else {
        return nil
    }
    guard let positions2 = map[word2] else {
        return nil
    }
    var index1 = 0
    var index2 = 0
    var result = (word1: 0, word2: 0)
    var bestDistance = Int.max
    while index1 < positions1.count && index2 < positions2.count {
        let pos1 = positions1[index1]
        let pos2 = positions2[index2]
        let distance = abs(pos1 - pos2)
        if distance < bestDistance {
            bestDistance = distance
            result.word1 = pos1
            result.word2 = pos2
        }
        if pos1 < pos2 {
            index1 += 1
        } else {
            index2 += 1
        }
    }
    return result
}

// Test
let words = ["aaa", "bbb", "ccc", "ddd", "eee", "fff", "ggg", "hhh", "iii", "aaa", "kkk", "lll", "ddd", "aaa", "ooo", "ppp", "qqq", "aaa"]
let wordsMap = createPositionsMap(words)
let word1 = "aaa"
let word2 = "ddd"
if let pair = findClosestPair(word1: word1, word2: word2, map: wordsMap) {
    let distance = abs(pair.word1 - pair.word2)
    print("Distance between \"\(word1)\" and \"\(word2)\": \(distance) (\(pair.word1), \(pair.word2))")
} else {
    print("Error: A word is not in the list (\(word1), \(word2))")
}
