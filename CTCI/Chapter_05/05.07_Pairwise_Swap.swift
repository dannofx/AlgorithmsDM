//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Pairwise Swap

import Foundation

extension UInt {

    var binaryString: String {
        return convertToBinaryString(size: UInt.bitWidth)
    }
    
    func convertToBinaryString(size: Int) -> String {
        let mask: UInt = UInt(1) << (size - 1)
        let signBit = ( mask & self ) != 0 ? "1" : "0"
        let number = ~mask & self
        let binaryForm = String(number, radix: 2)
        return signBit + String(repeatElement("0", count: size - binaryForm.count - 1)) + binaryForm
    }

}

func swapBits(_ input: UInt) -> UInt {
    var mask: UInt = 0x55555555
    var count = 32
    while count < UInt.bitWidth {
        mask = mask | mask << count
        count *= 2
    }
    return ((input & mask) << 1) | ((input & (mask << 1)) >> 1)
}

let input: UInt = 5647832
let swapped = swapBits(input)
print("Input:   \(input.binaryString)")
print("Swapped: \(swapped.binaryString)")

