//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// The Egg Drop Problem

import Foundation

let breakingFloor = 99

/// Drop an egg from a certain floor
///
/// - Parameter floor: Number of floor
/// - Returns: true if egg broke, false otherwise
func dropEgg(floor: Int) -> Bool {
    return floor >= breakingFloor
}

/// Find the lower floor from which a droped egg would break
///
/// - Parameter floors: Total number of floors in the building
/// - Returns: Returns the found flor, will return nil if the number of floors
///            is less or equals than zero or the building is too short so an
///            egg could break.
func findBreakingFloor(floors: Int) -> Int? {
    if floors <= 0 && breakingFloor > floors {
        return nil
    }
    if breakingFloor <= 0 {
        return 0
    }
    let initialInterval = Int(ceil((-1 + sqrt(1 + Double(floors) * 8)) / 2))
    var interval = initialInterval
    var egg1 = interval
    while !dropEgg(floor: egg1) && egg1 <= floors {
        interval -= 1
        egg1 += interval
    }
    var egg2 = egg1 - interval + 1
    while egg2 < egg1 && egg2 < floors && !dropEgg(floor: egg2) {
        egg2 += 1
    }
    return egg2
}

let floors = 100
if let foundFloor = findBreakingFloor(floors: floors) {
    print("The braking floor for a building of \(floors) floors is: \(foundFloor)")
} else {
    print("The breaking floor could not be found.")
}
