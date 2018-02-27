// Conversion

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

func getNeededSwaps(_ a: UInt, _ b: UInt) -> Int {
    var diff = a ^ b
    var count = 0
    while diff != 0 {
        count += 1
        diff = diff & ( diff - 1)
    }
    return count
}

let a: UInt = 4
let b: UInt = 60
print("A \(a): \(a.binaryString)")
print("B \(b): \(b.binaryString)")
print("Required swaps: \(getNeededSwaps(a, b))")


