// Insertion

import Foundation

infix operator >>>> : BitwiseShiftPrecedence

extension Int {

    var binaryString: String {
        let mask = 0b1 << (Int.bitWidth - 1)
        let signBit = ( mask & self ) != 0 ? "1" : "0"
        let number = ~mask & self
        let binaryForm = String(number, radix: 2)
        return signBit + String(repeatElement("0", count: Int.bitWidth - binaryForm.count - 1)) + binaryForm
    }

    static func >>>> (lhs: Int, rhs: Int) -> Int {
        let mask = ~( ~0 << (Int.bitWidth - rhs))
        return ( lhs >> rhs ) & mask
    }
}

extension Int {
    func insertBin(number: Int, start: Int, end: Int) -> Int{
        let mask = ( ~0 >>>> (Int.bitWidth + start - end - 1) ) << start
        let insertion = (number << start) & mask
        let cont = self & ~mask
        return cont | insertion
    }
}

let number = 0b10000000000
let addition = 0b10011
print("Binary: \(number.insertBin(number: addition, start: 2, end: 6).binaryString)")

