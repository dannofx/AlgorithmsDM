//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Contiguous sequence

import Foundation

func findMaxSubSequence(_ sequence: [Int]) -> (sum: Int, subsequence: [Int]) {
  var sub = (start: 0, end: 0)
  var sum = 0
  var maxSub = (start: 0, end: 0)
  var maxSum = 0
  for (i, number) in sequence.enumerated() {
    sum += number
    sub.end = i
    if sum > maxSum {
      maxSum = sum
      maxSub = sub
    } else if sum < 0 {
      sum = 0
      sub = (start: i + 1, end: i + 1)
    }
  }
  return (maxSum, [Int](sequence[maxSub.start...maxSub.end]))
}

let sequence = [2, -8, 3, -2, 4, -10]
//let sequence = [2, 8, 3, 2, 4, 10, -20]
//let sequence = [3, 4, 6, 9,-22, 10, 24, 15]
let max = findMaxSubSequence(sequence)
print("Sequence: \(sequence)")
print("Max sum: \(max.sum)")
print("Max subsequence: \(max.subsequence)")