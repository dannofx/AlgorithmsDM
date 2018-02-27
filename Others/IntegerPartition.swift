//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Integer partitions
import Foundation

func integerPartition(_ n: Int) -> [[Int]]{
    var workPartition = [Int].init(repeating: 0, count: n)
    var lastIndex = 0
    var partitions = [[Int]]()
    workPartition[0] = n
    while true {
        // Save current partition
        let partition = Array(workPartition[0...lastIndex])
        partitions.append(partition)
        
        var onesVal = 0
        while lastIndex >= 0 && workPartition[lastIndex] == 1 {
            onesVal += workPartition[lastIndex]
            lastIndex -= 1
        }
        
        if lastIndex < 0 {
            // exit because all values are 1
            return partitions
        }
        //Decrease the last no one value and adjust the one's sum
        workPartition[lastIndex] -= 1
        onesVal += 1
        // lastVal represents the major value that can take a position
        // after lastIndex to keep the order (equal or less)
        let lastVal = workPartition[lastIndex]
        // If after breaking the value at lastIndex the order is not kept
        // (because all the ones will be replaced by just one position
        // with the value onesVal), distribute this greater value among
        // more than one position trying to use as few as posible.
        // This will result in all positions after lastIndex will have a value
        // of lastVal and the last one the remaining ( onesVal % lastVal)
        while onesVal > workPartition[lastIndex] {
            workPartition[lastIndex + 1] = lastVal
            onesVal = onesVal - lastVal
            lastIndex += 1
        }
        lastIndex += 1
        workPartition[lastIndex] = onesVal
    }
}

let partitions = integerPartition(5)
print("Partitions")
for partition in partitions {
    print(partition)
}
