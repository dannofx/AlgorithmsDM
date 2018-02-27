//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Smallest difference

import Foundation

func calculateSmallestDifference(_ unsortedA: [Int], _ unsortedB: [Int]) -> Int {
    precondition(unsortedA.count > 0 && unsortedB.count > 0)
    let a = unsortedA.sorted()
    let b = unsortedB.sorted()
    var i = 0
    var j = 0
    var smtDiff = Int.max
    while i < a.count && j < b.count {
        let diff = abs(a[i] - b[j])
        if diff == 0 {
            return 0
        }
        if diff < smtDiff {
            smtDiff = diff
        }
        if a[i] < b[j] {
            i += 1
        } else {
            j += 1
        }
        
    }
    return smtDiff
}

let a = [10, 5, 6, 15,13, 20]
let b = [0, 23, 7, 8, 17, 23, 20, 54]
let smallest = calculateSmallestDifference(a, b)
print("Smallest difference: \(smallest)")
