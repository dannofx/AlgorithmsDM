// The Masseuse

import Foundation

func findMaxTime(massages: [Int]) -> Int{
    var oneAway = 0
    var twoAway = 0
    for massage in massages {
        let with = twoAway + massage
        let without = oneAway
        twoAway = oneAway
        oneAway = max(with, without)
    }
    return max(oneAway, twoAway)
}

let massages = [30, 15, 60, 75, 45, 15, 15, 45]
let maxTime = findMaxTime(massages: massages)
print("Massages: \(massages)")
print("Max time: \(maxTime)")
