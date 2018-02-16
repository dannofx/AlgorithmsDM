// Missing Number

import Foundation

// MARK: - Bit accessor

extension UInt {
    subscript(i: Int) -> Bool {
        get {
            return (self & 1 << i) != 0
        }
        set(newValue) {
            let val: UInt = (newValue ? 1 << i : 0)
            self = (self & ~val) | val
        }
    }
}

// MARK: - My solution

extension UInt {
    func countRange0Bits(_ i: Int) -> UInt {
        precondition(self != UInt.max)
        precondition(i < UInt.bitWidth)
        let n = self + 1
        let last = UInt.bitWidth - 1
        if i < last {
            let power = UInt(1) << (i + 1)
            // If n was an exact power of 2 or a multiple, the number of zeroes
            // is easy to calculate:
            // (number of 2^n in number) * (number of zeroes that is the half of the bits)
            let powerPart = (n / power) * (power / 2)
            let remainder = n % power
            // The maximum number of 0's that can have the remainder is power / 2
            let max0sRemain = power / 2
            let noPowerPart = (remainder > max0sRemain ? max0sRemain : remainder)
            return powerPart + noPowerPart
        } else {
            let limit = (UInt(1) << last)
            return n >= limit ? limit - 1 : n
        }
    }
}

func findMissingNumber2(array: [UInt]) -> UInt {
    let n = UInt(array.count)
    var missingNumber: UInt =  0
    for bIndex in 0..<UInt.bitWidth {
        var zeroCount: UInt = 0
        let expectedZeroes = n.countRange0Bits(bIndex)
        for number in array {
            if !number[bIndex] {
                zeroCount += 1
            }
        }
        missingNumber[bIndex] = expectedZeroes == zeroCount
    }
    return missingNumber
}

// MARK: Book's solution

func findMissingNumber(array: [UInt], bIndex: Int) -> UInt {
    if bIndex == UInt.bitWidth {
        return 0
    }
    var oneBits = [UInt]()
    var zeroBits = [UInt]()
    for num in array {
        if num[bIndex] {
            oneBits.append(num)
        } else {
            zeroBits.append(num)
        }
    }
    if zeroBits.count <= oneBits.count {
        // Has a zero
        let missing = findMissingNumber(array: zeroBits, bIndex: bIndex + 1)
        return (missing << 1) | 0
    } else {
        // Has a one
        let missing = findMissingNumber(array: oneBits, bIndex: bIndex + 1)
        return (missing << 1) | 1
    }
}

func findMissingNumber(array: [UInt]) -> UInt {
    return findMissingNumber(array: array, bIndex: 0)
}

var numbers = [UInt](0...100000)
numbers.remove(at: 8873)
let missingNumber = findMissingNumber(array: numbers)
print("Array: ")
print(numbers)
print("Missing number: \(missingNumber)")

