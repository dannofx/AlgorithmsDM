// Is Unique

import Foundation

extension Int {
    subscript(bIndex: Int) -> Bool {
        get {
            precondition(bIndex >= 0 && bIndex < Int.bitWidth)
            let mask = 1 << bIndex
            return self & mask != 0
        }
        set(newValue) {
            precondition(bIndex >= 0 && bIndex < Int.bitWidth)
            let value = (newValue ? 1 : 0) << bIndex
            let mask = ~(1 << bIndex)
            self = (self & mask) | value
        }
    }
}

extension Character {
    var letterValue: Int? {
        if !("a"..."z" ~= self) {
            return nil
        }
        let str = String(self)
        return Int(str.utf8[str.utf8.startIndex]) - 97
    }
}

extension String {
    var hasUniqueChars: Bool {
        var reg = 0
        for char in self {
            guard let index = char.letterValue else {
                preconditionFailure()
            }
            if reg[index] {
                return false
            }
            reg[index] = true
        }
        return true
    }
}

let word = "year"
print("Word \"\(word)\" has unique chars: \(word.hasUniqueChars)")

