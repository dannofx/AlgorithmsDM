// Knapsack problem that returns the indexes of the elements
// that were added to the knapsack.

import Foundation

typealias Solution = (value: Int, isIncluded: Bool)
typealias Item = (weight: Int, value: Int)

func trackSolution(solutions: [[Solution]], items: [Item]) -> [Int] {
    var limit = solutions[0].count - 1
    var eIndex = solutions.count - 1
    var solElements = [Int]()  
    while eIndex > 0 {
      let sol = solutions[eIndex][limit]
      if sol.isIncluded {
        solElements.append(eIndex)
        limit -= items[eIndex - 1].weight
      }
      eIndex -= 1
    }
  return solElements
}

func findValueSolutions(maxWeight: Int, items: [Item]) -> [[Solution]] {
    let n = items.count
    let defaultRow = [Solution](repeating: (0, false), count: maxWeight + 1)
    var solutions = [[Solution]](repeating: defaultRow, count: n + 1)
    for procIndex in 1...n {
        let cElemIndex = procIndex - 1
        for cWeightLimit in 1...maxWeight {
             if items[cElemIndex].weight > cWeightLimit {
                 solutions[procIndex][cWeightLimit] = (solutions[procIndex - 1][cWeightLimit].value, false)
             } else {
                 let pLimit = cWeightLimit - items[cElemIndex].weight
                 let withValue = items[cElemIndex].value + solutions[procIndex - 1][pLimit].value
                 let withoutValue = solutions[cElemIndex][cWeightLimit].value
                 if withValue >= withoutValue {
                   solutions[procIndex][cWeightLimit] = (withValue, true)
                 } else {
                   solutions[procIndex][cWeightLimit] = (withoutValue, false)
                 }
             }
        }
  }
  return solutions

}

func fillKnapsack(maxWeight: Int, items: [Item]) -> [Int] {
  let solutions = findValueSolutions(maxWeight: maxWeight, items: items)
  return trackSolution(solutions: solutions, items: items)
}

let maxWeight = 50
var items = [(weight: Int, value: Int)]()
items.append((10, 60))
items.append((20, 100))
items.append((30, 120))
let solution = fillKnapsack(maxWeight: maxWeight, items: items)
print("Solution indexes: \(solution)")