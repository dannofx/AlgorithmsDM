// 100 lockers

import Foundation

func countOpenLockers(lockersNumber: Int) -> Int {
//    var openLockers = 0
//    var factor = 1
//    let maxFactor: Int = Int(sqrt(Double(lockersNumber)))
//    while factor <= maxFactor {
//        openLockers += 1
//        factor += 1
//    }
//    return openLockers
    return Int(sqrt(Double(lockersNumber)))
}

let lockersNumber = 100
print("The number of open lockers in a group of \(lockersNumber) lockers is: \(countOpenLockers(lockersNumber: lockersNumber))")
