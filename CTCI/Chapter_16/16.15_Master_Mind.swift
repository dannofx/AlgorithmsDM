// Master Mind

import Foundation

extension Character {
    static var indexCount: Int {
        return 4
    }
    
    var index: Int {
        if self == "r" || self == "R" {
            return 0
        } else if self == "g" || self == "G" {
            return 1
        } else if self == "b" || self == "B" {
            return 2
        } else if self == "y" || self == "Y" {
            return 3
        }
        preconditionFailure()
    }
}

extension String {
    subscript(i: Int) -> Character{
        get {
            let index = self.index(self.startIndex, offsetBy: i)
            return self[index]
        }
    }
}

func compare(solution: String, guess: String) -> (hits: Int, pseudohit: Int){
    precondition(solution.count > 0)
    precondition(solution.count == guess.count)
    var hits = 0
    var pseudohits = 0
    var charCounts = [Int](repeating: 0, count: Character.indexCount)
    for i in 0..<solution.count {
        let sCharIndex = solution[i].index
        let gCharIndex = guess[i].index
        if sCharIndex == gCharIndex {
            hits += 1
        } else {
            charCounts[sCharIndex] += 1
        }
    }
    
    for i in 0..<guess.count {
        let sCharIndex = solution[i].index
        let gCharIndex = guess[i].index
        if sCharIndex != gCharIndex && charCounts[gCharIndex] > 0 {
            charCounts[gCharIndex] -= 1
            pseudohits += 1
        }
    }
    return (hits, pseudohits)
}

let guess = "GBGY"
let solution = "GBYR"
let (hits, pseudohits) = compare(solution: solution, guess: guess)
print("Solution: \(solution), Guess: \(guess)")
print("Hits: \(hits), Pseudohits: \(pseudohits)")
