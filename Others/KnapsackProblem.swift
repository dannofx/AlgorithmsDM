//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Knapsack problem

// Given weights and values of n items, put these items in a knapsack of capacity
// W to get the maximum total value in the knapsack. In other words, given two
// integer arrays val[0..n-1] and wt[0..n-1] which represent values and weights
// associated with n items respectively. Also given an integer W which represents
// knapsack capacity, find out the maximum value subset of val[] such that sum of
// the weights of this subset is smaller than or equal to W. You cannot break an
// item, either pick the complete item, or don’t pick it (0-1 property).


// This solution could work with floating points but the O(n) is 2^n
//func knapsackProblem(maxWeight: Int, items: [(weight: Int, value: Int)]) -> Int {
//    return knapsackProblem(maxWeight: maxWeight, lastIndex: items.count, items: items)
//}
//
//func knapsackProblem(maxWeight: Int, lastIndex: Int, items: [(weight: Int, value: Int)]) -> Int {
//    if lastIndex == 0 || maxWeight <= 0 {
//        return 0
//    }
//    let i = lastIndex - 1
//    if items[i].weight > maxWeight {
//        return knapsackProblem(maxWeight: maxWeight, lastIndex: i, items: items)
//    } else {
//        let with = items[i].value + knapsackProblem(maxWeight: (maxWeight - items[i].weight), lastIndex: i, items: items)
//        let without = knapsackProblem(maxWeight: maxWeight, lastIndex: i, items: items)
//        return max(with, without)
//    }
//}

// Dynamic programming solution
func knapsackProblem(maxWeight: Int, items: [(weight: Int, value: Int)]) -> Int {
    let n = items.count
    var solutions = [[Int]](repeating: [Int](repeating: 0, count: maxWeight + 1), count: n + 1)
    for i in 1...n {
        for w in 1...maxWeight {
            if items[i - 1].weight > w {
                solutions[i][w] = solutions[i - 1][w]
            } else {
                let with = items[i - 1].value + solutions[i - 1][w - items[i - 1].weight]
                let without = solutions[i - 1][w]
                solutions[i][w] = max(with, without)
            }
        }
    }
    return solutions[n][maxWeight]
}

let maxWeight = 50
var items = [(weight: Int, value: Int)]()
items.append((10, 60))
items.append((20, 100))
items.append((30, 120))
let maxValue = knapsackProblem(maxWeight: maxWeight, items: items)
print("Max value: \(maxValue)")

