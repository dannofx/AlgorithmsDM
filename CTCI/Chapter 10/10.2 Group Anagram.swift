// Group Anagram

import Foundation

extension String {
    var sortedString: String {
        var chars: [Character] = Array(self)
        chars.sort()
        return String(chars)
    }
}

extension Array where Element == String {
    mutating func sortByAnagram() {
        var anagrams = [String: [String]]()
        for word in self {
            let sortedString = word.sortedString
            if anagrams[sortedString] == nil {
                anagrams[sortedString] = [word]
            } else {
                anagrams[sortedString]?.append(word)
            }
        }
        var index = 0
        for group in anagrams {
            for word in group.value {
                self[index] = word
                index += 1
            }
        }
    }
}


var input = ["doggy",
             "cat",
             "apple",
             "compute",
             "oggyd",
             "tac",
             "ppela",
             "putecom",
             "yggod",
             "tca",
             "elppa",
             "act",
             "oggyd",
             "leppa",
             "utempoc"]
input.sortByAnagram()
print("Sorted by anagram: \(input)")





