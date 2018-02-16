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
}

let a = 5
let b = 10
let result = a ++ b
print("Sum of \(a) and \(b): \(result)")