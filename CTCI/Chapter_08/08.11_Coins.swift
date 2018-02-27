// Coins

import Foundation

enum Coin: Int {
    case quarter = 25
    case dime = 10
    case nickel = 5
    case penny = 1
}

let denominations: [Coin] = [.quarter, .dime, .nickel, .penny]

// MARK: - Combinations

func calculateCombinations(n: Int, fcIndex: Int, cache: inout [Int: [Int: [[Coin]]]]) -> [[Coin]] {
    if cache[fcIndex] != nil && cache[fcIndex]![n] != nil {
        return cache[fcIndex]![n]!
    }
    var combinations = [[Coin]]()
    for i in fcIndex..<denominations.count {
        let coin = denominations[i]
        let remaining = n - coin.rawValue
        if remaining == 0 {
            combinations.append([coin])
        } else if remaining > 0 {
            var remCombinations = calculateCombinations(n: remaining, fcIndex: i, cache: &cache)
            for i in 0..<remCombinations.count {
                remCombinations[i].append(coin)
                combinations.append(remCombinations[i])
            }
        }
    }
    if cache[fcIndex] == nil {
        cache[fcIndex] = [Int: [[Coin]]]()
    }
    cache[fcIndex]![n] = combinations
    return combinations
}

func calculateCombinations(n: Int) -> [[Coin]] {
    var cache = [Int: [Int: [[Coin]]]]()
    return calculateCombinations(n: n, fcIndex: 0, cache: &cache)
}

// MARK: - Number of combinations

func calculateCombinationsNumber(n: Int, fcIndex: Int, cache: inout [Int: [Int: Int]]) -> Int {
    if cache[fcIndex] != nil && cache[fcIndex]![n] != nil {
        return cache[fcIndex]![n]!
    }
    var numbers = 0
    for i in fcIndex..<denominations.count {
        let coin = denominations[i]
        let remaining = n - coin.rawValue
        if remaining == 0 {
            numbers += 1
        } else if remaining > 0 {
            numbers += calculateCombinationsNumber(n: remaining, fcIndex: i, cache: &cache)
        }
    }
    if cache[fcIndex] == nil {
        cache[fcIndex] = [Int: Int]()
    }
    cache[fcIndex]![n] = numbers
    return numbers
}

func calculateCombinationsNumber(n: Int) -> Int {
    var cache = [Int: [Int: Int]]()
    return calculateCombinationsNumber(n: n, fcIndex: 0, cache: &cache)
}

// MARK: - Tests

let n = 30
let combinations = calculateCombinations(n: n)
print("Combinations for \(n) cents:")
for combination in combinations {
    var comStr = ""
    for coin in combination {
        comStr.append("\(coin.rawValue),")
    }
    print(comStr)
}

let combinationsNumber = calculateCombinationsNumber(n: n)
print("Number of combinations for \(n) cents: \(combinationsNumber)")



