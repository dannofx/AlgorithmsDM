//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Poison

import Foundation

let poisonedIndex = 30
let daysForResult = 7

extension UInt {
    var usedBits: Int {
        var val = self
        var bits = 0
        while val != 0 {
            val >>= 1
            bits += 1
        }
        return bits
    }
}

class Bottle {
    let identifier: UInt
    var isPoisoned: Bool {
        return self.identifier == poisonedIndex
    }
    
    init(identifier: UInt) {
        self.identifier = identifier
    }
}

class TestStrip {
    private var dropsByDay: [[Bottle]]
    
    init() {
        dropsByDay = [[Bottle]]()
    }
    
    func addDropOnDay(day: Int, bottle: Bottle) {
        while day >= self.dropsByDay.count {
            self.dropsByDay.append([Bottle]())
        }
        self.dropsByDay[day].append(bottle)
    }
    
    func isPositive(onDay day: Int) -> Bool {
        let testDay = day - daysForResult
        if testDay < 0 || testDay >= dropsByDay.count {
            return false
        }
        for prevDay in 0...testDay {
            for bottle in self.dropsByDay[prevDay] {
                if bottle.isPoisoned {
                    return true
                }
            }
        }
        return false
    }
}

func runTests(bottles: [Bottle], testStrips: [TestStrip]) {
    for bottleIndex in 0..<bottles.count {
        for stripIndex in 0..<testStrips.count {
            let mask: UInt = 1 << stripIndex
            if mask & UInt(bottleIndex) > 0 {
                testStrips[stripIndex].addDropOnDay(day: 0, bottle: bottles[bottleIndex])
            }
        }
    }
}

func findPoisonedBottleIndex(testStrips: [TestStrip]) -> Int {
    var index = 0
    for (i, testStrip) in testStrips.enumerated() {
        let bit = testStrip.isPositive(onDay: 7) ? 1 : 0
        index =  index | bit << i
    }
    return index
}

func findPoisonedBottle(bottles: [Bottle], testStrips: [TestStrip]) -> Bottle? {
    if UInt(bottles.count).usedBits > testStrips.count {
        return nil
    }
    runTests(bottles: bottles, testStrips: testStrips)
    let index = findPoisonedBottleIndex(testStrips: testStrips)
    return bottles[index]
}

var bottles = [Bottle]()
for i in 0...999 {
    bottles.append(Bottle(identifier: UInt(i)))
}
var testStrips = [TestStrip]()
for _ in 0...9 {
    testStrips.append(TestStrip())
}

if let poisonedBottle = findPoisonedBottle(bottles: bottles, testStrips: testStrips) {
    print("Poisoned bottle: \(poisonedBottle.identifier)")
} else {
    print("Error retrieving poisoned bottle")
}


