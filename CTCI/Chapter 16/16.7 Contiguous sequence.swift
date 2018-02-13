// Contiguous sequence

import Foundation

func findMaxSubSequence(_ sequence: [Int]) -> (sum: Int, subsequence: [Int]) {
    var currentSub = [Int]()
    var currentSum = 0
    var maxSub = [Int]()
    var maxSum = 0
    for i in 0..<sequence.count {
        currentSub.append(sequence[i])
        currentSum += sequence[i]
        if currentSum > maxSum {
            maxSum = currentSum
            maxSub = currentSub
        } else if currentSum < 0 {
            currentSub = [Int]()
            currentSum = 0
        }
    }
    return (maxSum, maxSub)
}

let sequence = [2, -8, 3, -2, 4, -10]
//let sequence = [2, 8, 3, 2, 4, 10, -20]
//let sequence = [3, 4, 6, 9,-22, 10, 24, 15]
let max = findMaxSubSequence(sequence)
print("Sequence: \(sequence)")
print("Max sum: \(max.sum)")
print("Max subsequence: \(max.subsequence)")

