// Next number

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

func countTrailing(value: UInt, pattern: UInt) -> (c0: UInt, c1: UInt)? {
    var currentBit = 0
    var c0: UInt = 0
    var c1: UInt = 0
    while currentBit < UInt.bitWidth {
        let mask: UInt = 0b11 << currentBit
        if ( value & mask ) == pattern << currentBit {
            if pattern == 0b01 {
                c1 += 1
            } else {
                c0 += 1
            }
            break
        } else if (value & (0b1 << currentBit)) > 0 {
            c1 += 1
        } else {
            c0 += 1
        }
        currentBit += 1
        if currentBit == UInt.bitWidth - 1{
            return nil
        }
    }
    return (c0, c1)
}

func getNext(_ input: UInt) -> UInt? {
    guard let (c0, c1) = countTrailing(value: input, pattern: 0b01) else {
        return nil
    }
    return input + (1 << c0) + (1 << (c1 - 1)) - 1
}

func getPrevious(_ input: UInt) -> UInt? {
    guard let (c0, c1) = countTrailing(value: input, pattern: 0b10) else {
        return nil
    }
    return input - (1 << c1) - (1 << (c0 - 1)) + 1
}

let input:UInt = 45
print("Input \(input): \(input.binaryString)")
let next = getNext(input)!
print("Next \(next): \(next.binaryString)")
let previous = getPrevious(input)!
print("Previous \(previous): \(previous.binaryString)")


