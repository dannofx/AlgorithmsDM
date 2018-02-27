// Longest word

import Foundation

extension String {
    func substring(from: Int) -> String {
        let index = self.index(self.startIndex, offsetBy: from)
        return String(self[index...])
    }
    
    func split(at: Int) -> (left: String, right: String) {
        precondition(at >= 0 && at < self.count)
        let index = self.index(self.startIndex, offsetBy: at)
        let substring1 = String(self[self.startIndex..<index])
        let substring2 = String(self[index...])
        return (substring1, substring2)
    }
}

func isComposedWord(currentWord: String, wordsDict: inout [String : Bool], isOriginal: Bool) -> Bool {
    if currentWord.count == 0 {
        return true
    }
    if let result = wordsDict[currentWord], !isOriginal {
        return result
    }
    for i in 1..<currentWord.count {
        let (subword1, subword2) = currentWord.split(at: i)
        if wordsDict[subword1] ?? false {
            let isComposed = isComposedWord(currentWord: subword2,
                                            wordsDict: &wordsDict,
                                            isOriginal: false)
            if isComposed {
                wordsDict[currentWord] = true
                return true
            }
        }
    }
    wordsDict[currentWord] = false
    return false
}

func findLongestWord(_ uWords: [String]) -> String? {
    let words = uWords.sorted { $0.count > $1.count }
    var wordsDict = words.reduce(into: [String: Bool]()) { $0[$1] = true}
    for word in words {
        let isComposed = isComposedWord(currentWord: word,
                                        wordsDict: &wordsDict,
                                        isOriginal: true)
        if isComposed {
            return word
        }
    }
    return nil
}

let words = ["cat", "banana", "dog", "nana", "walk", "walker", "dogwalker", "dogwalkerrr", ""]
print("Words: \(words)")
if let longestWord = findLongestWord(words) {
    print("Longest composed word: \(longestWord)")
} else {
    print("Error: No composed words found")
}

