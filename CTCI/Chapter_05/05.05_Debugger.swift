// Debugger

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
    
    var isPowerOfTwo: Bool {
        return ( self & ( self - 1 ) ) == 0
    }
}

let input: UInt = 16
print("\(input) is power of 2: \(input.isPowerOfTwo)")


