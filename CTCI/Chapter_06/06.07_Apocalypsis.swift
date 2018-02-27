//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// The Apocalypse

import Foundation

/// Deduce the rate of women born in the country
///
/// - Returns: The rate of women born (number between 0.0 and 1.0)
func guessRateOfWomen() -> Double {
    
    // The families will be divided in groups according to the number of kids they have.
    // According to the decret, the families must stop having kids when they conceive a girl.
    // So, if B represents a boy and G a girl, the secuence of kids of every group of families
    // will be:
    // Group 1: G     -> Families with one kid (a girl)
    // Group 2: BG    -> Families with two kids (a boy and a girl)
    // Group 3: BBG   -> Families with three kids (two boys and a girl)
    // Group 4: BBBG  -> Families with four kids (three boys and a girl)
    // ...
    
    let limit = 100000000 // The maximum number of kids that a family can have (should be infinity)
    var familiesToCount = 1.0 // Represents the total number of families in the country
    var bornChildrenTotal = 0.0
    var rate = 0.0
    for i in 1...limit {
        // Each iteration represents a group of families that will have i kids.
        let childrenPerFamily = Double(i)
        // Half of the remaining families will stop having kids in this iteration, because they will have a girl.
        let familiesInGroup = familiesToCount / 2.0
        bornChildrenTotal += familiesInGroup * childrenPerFamily
        // The families that had a boy won't stop having kids now, so they will still be pending to count.
        familiesToCount = familiesToCount / 2.0
    }
    familiesToCount = 1.0
    for i in 1...limit {
        let childrenPerFamily = Double(i)
        let familiesInGroup = familiesToCount / 2.0
        // The total children born in this group is calculated again
        let bornChildrenInGroup = familiesInGroup * childrenPerFamily
        // The children in this group are compared to the total of children born to get the percentage
        let percentageInTotal = bornChildrenInGroup / bornChildrenTotal
        // Women probability in a family in this group. There is just a woman per family
        let womenProbability = (1.0 / childrenPerFamily)
        // This obtains the rate of a women born not just in the this groups of families, but the total new population of born children.
        rate += percentageInTotal * womenProbability
        familiesToCount = familiesToCount / 2.0
    }
    
    return rate
}

/// Simulates the birth of children in a certain number of families
///
/// - Parameter families: Number of families to simulate.
/// - Returns: The number of women and the number of men born.
func simulateBirth(families: Int) -> (women: Int, men: Int) {
    var womenCount = 0
    var menCount = 0
    for _ in 0..<families {
        while arc4random() % 2 == 0 {
            menCount += 1
        }
        womenCount += 1
    }
    return (womenCount, menCount)
}

let birth = simulateBirth(families: 10000000)
let rateWomen = Double(birth.women) / Double(birth.women + birth.men)
print("Deduced women rate: \(guessRateOfWomen())")
print("Simulated women rate: \(rateWomen)")

