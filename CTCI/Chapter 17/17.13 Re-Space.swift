// Re-Space

import Foundation

extension String {
    subscript(i: Int) -> Character {
        get {
            let index = self.index(self.startIndex, offsetBy: i)
            return self[index]
        }
    }
}

typealias Solution = (text: String, invalid: Int)

func findBestSplit(dictionary: Set<String>, text: String, index: Int, solutions: inout [Solution?]) -> Solution {
    if index == text.count {
        return Solution(text: "", invalid: 0)
    }
    if let solution = solutions[index] {
        return solution
    }
    var word = ""
    var bestSolution = Solution(text: "", invalid: Int.max)
    for i in index..<text.count {
        let character = text[i]
        word.append(character)
        let invalidChars = dictionary.contains(word) ? 0 : word.count
        if invalidChars < bestSolution.invalid {
            let solution = findBestSplit(dictionary: dictionary, text: text, index: i + 1, solutions: &solutions)
            let totalInvalid = invalidChars + solution.invalid
            if totalInvalid < bestSolution.invalid {
                if index == 0 {
                    print(invalidChars)
                }
                bestSolution.text = "\(word) \(solution.text)"
                bestSolution.invalid = totalInvalid
            }
        }
    }
    solutions[index] = bestSolution
    return bestSolution
}

func findBestSplit(dictionary: Set<String>, text: String) -> String {
    var solutions = [Solution?](repeating: nil, count: text.count)
    let solution = findBestSplit(dictionary: dictionary, text: text, index: 0, solutions: &solutions)
    return solution.text
}

let words = ["the", "dog", "food", "eating", "does","like", "it"]
let dictionary = Set<String>(words)
let text = "thedogiseatingitsfoodbutdoesnotlikeit"
let splitText = findBestSplit(dictionary: dictionary, text: text)
print(splitText)
