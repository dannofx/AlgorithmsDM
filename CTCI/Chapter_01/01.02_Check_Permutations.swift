// Check Permutations

import Foundation

extension Character {
    // Assumption
    var letterValue: Int? {
        if !("a"..."z" ~= self) {
            return nil
        }
        let str = String(self)
        return Int(str.utf8[str.utf8.startIndex]) - 97
    }
    
    static var maxLetterValue: Int{
        return Character("z").letterValue!
    }
}

extension String {
    func isPermutation(_ other: String) -> Bool {
        if self.count != other.count {
            return false
        }
        var reg = [Int](repeating: 0, count: Character.maxLetterValue + 1)
        for char in self {
            guard let index = char.letterValue else {
                preconditionFailure()
            }
            reg[index] += 1
        }
        for char in other {
            guard let index = char.letterValue else {
                preconditionFailure()
            }
            reg[index] -= 1
            if reg[index] < 0 {
                return false
            }
        }
        return true
    }
}

let word1 = "dog"
let word2 = "god"
print("\(word1) in permutation of \(word2): \(word1.isPermutation(word2))")

