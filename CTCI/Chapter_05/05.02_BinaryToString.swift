//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Binary to String

import Foundation

infix operator >>>> : BitwiseShiftPrecedence

extension Int {

    var binaryString: String {
        return convertToBinaryString(size: Int.bitWidth)
    }
    
    func convertToBinaryString(size: Int) -> String {
        let mask = 0b1 << (size - 1)
        let signBit = ( mask & self ) != 0 ? "1" : "0"
        let number = ~mask & self
        let binaryForm = String(number, radix: 2)
        return signBit + String(repeatElement("0", count: size - binaryForm.count - 1)) + binaryForm
    }

    static func >>>> (lhs: Int, rhs: Int) -> Int {
        let mask = ~( ~0 << (Int.bitWidth - rhs))
        return ( lhs >> rhs ) & mask
    }
}

func printFraction(number: Double) {
    if number <= 0.0 || number >= 1.0 {
        print("Error: Number is not a fraction.")
        return
    }
    var remaining =  number
    var result = 0
    var size = 0
    while remaining > 0 {
        if size == 32 {
            print("Error: The number will not be represented accurately. \(String(result, radix: 2))")
            return
        }
        size += 1
        remaining = remaining * 2
        result = result << 1 | Int(remaining)
        if remaining >= 1.0 {
            remaining -= 1.0
        }
    }
    print("." + result.convertToBinaryString(size: size))
}

printFraction(number: 0.375)
