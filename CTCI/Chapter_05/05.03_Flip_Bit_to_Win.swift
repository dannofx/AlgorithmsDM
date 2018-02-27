//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Flip Bit to Win

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

func getMaxFlippedSequence(input: Int) -> Int {
    var maxSequence = 0
    var sequence = 0
    var currentBit = 0
    var lastMax = 0
    while currentBit < Int.bitWidth {
        sequence += 1
        if ( input & ( 1 << currentBit ) ) == 0 {
            // Is zero
            sequence -= lastMax
            lastMax = sequence
        }
        if sequence > maxSequence {
            maxSequence = sequence
        }
        currentBit += 1
    }
    return maxSequence
    
}

let input = 1775
let maxSequence = getMaxFlippedSequence(input: input)
print("The max 1 sequence for \(input) is: \(maxSequence)")
