// Palindrome Permutation

import Foundation

let aValue = UnicodeScalar("a")!.value
let zValue = UnicodeScalar("z")!.value


func isPalindromePermutation(text: String) -> Bool{
    let cleanText = text.lowercased().unicodeScalars.filter{ $0.value >= aValue && $0.value <= zValue }
    var odds: Int32 = 0
    for character in cleanText {
        let charValue = character.value
        let offset = charValue - aValue
        let mask: Int32 = 1 << offset
        odds = odds ^ mask
    }
    let comprobation: Int32 = odds - 1
    return comprobation & odds == 0
}

let input = "Tact Coa"
let result = isPalindromePermutation(text: input)
print("The phase \"\(input)\" is palindrome permutation: \(result)")


