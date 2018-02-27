// Chapter 7, Exercise 7-15

import Foundation

let input = [0,1,2]
var solution = [Bool].init(repeating: false, count: input.count)

func generateSubsets(solution: inout [Bool], input: [Int], currentSize: Int) {
    if currentSize == input.count {
        var subset = [Int]()
        for (i, presence) in solution.enumerated() {
            if presence {
                subset.append(input[i])
            }
        }
        print("Subset: \(subset)")
        return
    }
    
    let possibilities = [true, false]
    for possibility in possibilities {
        solution[currentSize] = possibility
        generateSubsets(solution: &solution, input: input, currentSize: currentSize + 1)
    }
}

generateSubsets(solution: &solution, input: input, currentSize: 0)
