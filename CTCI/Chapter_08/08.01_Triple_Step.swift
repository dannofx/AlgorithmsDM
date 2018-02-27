// Triple Step

import Foundation

func calculateWays(n: Int, memo: inout [Int]) -> Int {
    if n < 0 {
        return 0
    }
    if memo[n] == -1 {
        if n == 0 {
            memo[n] = 1
        } else {
            memo[n] = calculateWays(n: n - 3, memo: &memo) +
                calculateWays(n: n - 2, memo: &memo) +
                calculateWays(n: n - 1, memo: &memo)
        }
    }
    return memo[n]
}

func calculateAllPossibleWays(staircase: Int) -> Int? {
    if staircase <= 0 {
        return nil
    } else {
        var memo = [Int](repeating: -1, count: staircase + 1)
        return calculateWays(n: staircase, memo: &memo)
    }
}

let n = 20
if let ways = calculateAllPossibleWays(staircase: n) {
    print("Number of ways to run up the stairs (\(n)): \(ways)")
} else {
    print("Invalid input: \(n)")
}
