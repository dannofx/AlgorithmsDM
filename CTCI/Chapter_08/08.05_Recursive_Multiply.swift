//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Recursive Multiply

import Foundation

func multiply(small: UInt, big: UInt) -> UInt {
    if small == 0 {
        return 0
    }
    if small == 1 {
        return big
    }
    let newSmall = small >> 1
    let half = multiply(small: newSmall, big: big)
    if small % 2 == 1 {
        return half + half + big
    } else {
        return half + half
    }
}

func multiply(a: UInt, b: UInt) -> UInt {
    let small = min(a, b)
    let big = max(a, b)
    return multiply(small: small, big: big)
}

let a: UInt = 10
let b: UInt = 7
print("\(a) * \(b) = \(multiply(a: a, b: b))")

