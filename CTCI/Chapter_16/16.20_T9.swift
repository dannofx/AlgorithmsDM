// T9

import Foundation

extension String {
    subscript(i: Int) -> Character {
        get {
            let index = self.index(self.startIndex, offsetBy: i)
            return self[index]
        }
    }
    
    var isNumber: Bool {
        return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}

// MARK: - Precompute data

let t9Letters: [[Character]] = [
                                [], //0
                                [], //1
                                ["a", "b", "c"], //2
                                ["d", "e", "f"], //3
                                ["g", "h", "i"], //4
                                ["j", "k", "l"], //5
                                ["m", "n", "o"], //6
                                ["p", "q", "r", "s"], //7
                                ["t", "u", "v"], //8
                                ["w", "x", "y", "z"] //9
                            ]

func createCharToNumberDictionary() -> [Character: Character] {
    var dictionary = [Character: Character]()
    for i in 0..<t9Letters.count {
        let number = "\(i)"[0]
        let numberLetters = t9Letters[i]
        for letter in numberLetters {
            dictionary[letter] = number
        }
    }
    return dictionary
}

func convertToNumber(word: String, charDictionary: [Character: Character]) -> String {
    var number = ""
    for character in word {
        if let digit = charDictionary[character] {
            number.append(digit)
        } else {
            preconditionFailure()
        }
    }
    return number
}

func createT9Dictionary(words: [String]) -> [String:  [String]] {
    let charDictionary = createCharToNumberDictionary()
    var numbersDictionary = [String: [String]]()
    for word in words {
        let number = convertToNumber(word: word, charDictionary: charDictionary)
        if numbersDictionary[number] == nil {
            numbersDictionary[number] = [word]
        } else {
            numbersDictionary[number]!.append(word)
        }
    }
    return numbersDictionary
}

// MARK: - Look up number

func getWords(forNumber number: String, t9Dictionary: [String: [String]]) -> [String]? {
    precondition(number.isNumber)
    return t9Dictionary[number]
}

// MARK: - Test
let words = ["dog", "doh", "cat", "fridge"]
let t9Dictionary = createT9Dictionary(words: words)
let number = "364"
print("Words for number \(number):")
if let words = getWords(forNumber: number, t9Dictionary: t9Dictionary) {
    print(words)
} else {
    print("(None)")
}
