// The heavy pill

import Foundation

let bottlesNumber = 20
let secretHeavyBottle = 19

/// Get the total weight of a collection of pills
/// of different bottles. For the purposes of this problem
/// the code inside this method must be considered a blackbox.
///
/// - Parameter bottlePills: Amounts of pills for every bottle, every item is the amount of pills from the bottle with that index
/// - Returns: The total weight or nil if the number of brought items is different from `bottlesNumber`
func weight(bottlePills: [Int]) -> Double? {
    if bottlePills.count != bottlesNumber {
        return nil
    }
    let lightWeight = 1.0
    let heavyWeight = 1.1
    var totalWeight = 0.0
    for i in 0..<bottlePills.count {
        let pillsNumber = bottlePills[i]
        let pillWeight = i == secretHeavyBottle ? heavyWeight : lightWeight
        totalWeight += Double(pillsNumber) * pillWeight
    }
    // The small fraction is added because sometimes
    // float numbers result of an addition can't be
    // represented accurately.
    // Example
    // .2 + .1 = 0.30000000000000004
    return totalWeight + 0.00000001
}

/// Find the bottle with heaviest pills
///
/// - Returns: The index of the bottle with heaviest pills
func findHeavierBottle() -> Int {
    var bottlePills = [Int]()
    for i in 1...bottlesNumber {
        bottlePills.append(i)
    }
    let realWeight = weight(bottlePills: bottlePills)!
    let idealWeight = Double(bottlesNumber * (bottlesNumber + 1) / 2)
    let remainder = realWeight - idealWeight
    return Int(remainder * 10) - 1
}

let heavierBottle = findHeavierBottle()
print("Index of the bottle with heaviest pills: \(heavierBottle)")

