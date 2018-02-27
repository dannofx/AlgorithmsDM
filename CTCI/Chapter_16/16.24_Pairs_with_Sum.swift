//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Pairs with Sum

import Foundation

// MARK: Hash table solution

//func findSumPairs(sum: Int, numbers: [Int]) -> [(Int, Int)] {
//    var pairs = [(Int, Int)]()
//    var unpairedNumbers = [Int: Int]() // The value ontains the number of repetitions
//    for number in numbers {
//        let complement = sum - number
//        if let complCount = unpairedNumbers[complement], complCount > 0 {
//            pairs.append((number, complement))
//            unpairedNumbers[number] = complCount - 1
//        } else {
//            unpairedNumbers[number] = (unpairedNumbers[number] ?? 0) + 1
//        }
//    }
//    return pairs
//}

// MARK: Sorting solution

func findSumPairs(sum: Int, numbers: [Int]) -> [(Int, Int)] {
    let sNumbers = numbers.sorted()
    var pairs = [(Int, Int)]()
    var left = 0
    var right = sNumbers.count - 1
    while left < right {
        let currentSum = sNumbers[left] + sNumbers[right]
        if currentSum == sum {
            pairs.append((sNumbers[left], sNumbers[right]))
            left += 1
            right += 1
        } else {
            if currentSum > sum {
                //too big
                right -= 1
            } else {
                // too small
                left += 1
            }
        }
    }
    return pairs
}

let numbers = [1,2,3,4,5,6,7,8,9,10]
let sum = 7
let results = findSumPairs(sum: sum, numbers: numbers)
print("Pairs with sum \(sum):")
print(results)
