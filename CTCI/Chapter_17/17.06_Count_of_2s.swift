//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Count of 2s

import Foundation

// MARK: - My solution

func count2s(_ n: Int) -> Int{
    precondition(n >= 0)
    var number = n
    var twos = 0
    var powerOf10 = 1
    var i = 0
    var rightPart = 0
    // The succession that represents the while is:
    // 01, 020, 0300, 04000, 008000, etc
    // That is the respective number of 2's in:
    // 10, 100, 1000, 10000, 100000, etc
    // (1) It sums every element of the succession according
    // to every digit, it means every digit is a factor for a
    // certain element in the succession. If we have a 400
    // we will take it as 100 * 4, so the number of twos will be
    // 20 * 4 = 80.
    // (2)It also considers the special case when the current
    //  digit is or cover 2. For example, the number 25 contains 9
    // twos and not 3 because the numbers 20,21,22,23,24 and 25
    // start with a 2. Something similar happens to the number 30
    // because cover all the numbers from 20 to 29. Another case is
    // 2135, when the digit that is being counted is 2, there are
    // 136 twos that need to be taken into account (the range 0-135).
    while number > 0 {
        let digit = number % 10
        var additionalTwos = 0
        if digit >= 2 {
            // 2
            additionalTwos = digit > 2 ? ((10 * powerOf10) / 10) : (rightPart + 1)
        }
        // 1
        twos += (digit * powerOf10 * i) / 10 + additionalTwos
        i += 1
        rightPart += digit * powerOf10
        number /= 10
        powerOf10 *= 10
    }
    return twos
    
}

// MARK: - Book's solution

func count2sInRange(_ n: Int, at dIndex: Int) -> Int {
    let powerOf10 = Int(pow(10.0, Double(dIndex)))
    let nextPowerOf10 = powerOf10 * 10
    let digit = (n / powerOf10) % 10
    let rightPart = n % powerOf10
    let roundDown = n - (n % nextPowerOf10)
    let roundUp = roundDown + nextPowerOf10
    if digit < 2 {
        return roundDown / 10
    } else if digit == 2 {
        return roundDown / 10 + rightPart + 1
    } else {
        return roundUp / 10
    }
}

func count2sInRange(_ n: Int) -> Int {
    precondition(n >= 0)
    var count = 0
    let len = String(n).count
    for i in 0..<len {
        count += count2sInRange(n, at: i)
    }
    return count
}

// MARK: - Test

let n = 15567
let count = count2s(n)
print("Number of 2's in \(n): \(count)")

