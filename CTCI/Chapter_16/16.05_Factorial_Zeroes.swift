//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Factorial Zeroes

import Foundation

// MARK: Approach with logarithms

//let epsilon = 0.00001
//infix operator ====: AdditionPrecedence
//
//extension Double {
//    static func ====(lhs: Double, rhs: Double) -> Bool {
//        return abs(lhs - rhs) < epsilon
//    }
//}
//
//func logC(val: Double, forBase base: Double) -> Double {
//    return log(val)/log(base)
//}
//
//func calculateFactors(factor: Double, number: Double) -> Int {
//    let factors = logC(val: number, forBase: factor)
//    if factors < 1.0 {
//        return 0
//    }
//    let remainder = pow(factor, (factors - floor(factors)))
//    if  remainder - floor(remainder) ==== 0.0{
//        return Int(factors)
//    }
//    return 0
//}
//
//func calculateLeadZeroes(factorial: Int) -> Int{
//    precondition(factorial >= 0)
//    if factorial < 2 {
//        return 0
//    }
//    var fives = 0
//    for i in stride(from: 5, through: factorial, by: 5) {
//        let id = Double(i)
//        fives += calculateFactors(factor: 5, number: id)
//    }
//    return fives
//}

// MARK: - Efficient approach

func calculateLeadZeroes(factorial: Int) -> Int{
    precondition(factorial >= 0)
    // 10 is represented as product of two primes: 5 and 2
    // We need all the pairs of these two numbers as factors,
    // but since always will be more 2's than 5's
    // we only count all the multiples of 5.
    // "All" referes to the sum of all fives as factors
    // of all the values of the iterations to get the factorial.
    var multiple = 5
    var fives = 0
    while factorial / multiple > 0 {
        fives += factorial / multiple
        multiple *= 5
    }
    return fives
}

let number = 20
let zeroes = calculateLeadZeroes(factorial: number)
print("Leading zeroes of \(number) factorial: \(zeroes)")


