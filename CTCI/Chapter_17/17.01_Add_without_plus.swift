//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Add Without Plus

import Foundation

infix operator ++: AdditionPrecedence

extension Int {
    static func ++(lhs: Int, rhs: Int) -> Int {
        let sum =  lhs ^ rhs
        let carry = (lhs & rhs) << 1
        if carry == 0 {
            return sum
        } else {
            return sum ++ carry
        }
    }
// Iterative approach
//    static func ++(lhs: Int, rhs: Int) -> Int {
//        var res = lhs
//        var b = rhs
//        while (b != 0) {
//            let temp = res
//            res = res ^ b
//            b = (temp & b) << 1
//        }
//        return res
//    }
    
}

let a = 5
let b = 10
let result = a ++ b
print("Sum of \(a) and \(b): \(result)")
