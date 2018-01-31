// Missing Int

import Foundation

let numbersCount = 100 // The variaty of values that can have the numbers
let bufferLimit = 40 // The limit in bytes for the buffer used for the solution



func createNumbers() -> [Int] {
    var numbers = [Int]()
    for _ in 0..<numbersCount {
        numbers.append(Int(arc4random() % 100))
    }
    return numbers
}

func findMissingNumber(numbers: [Int]) -> Int?{
    let uintByteWidth = (UInt.bitWidth / 8)
    var byteSize = bufferLimit / uintByteWidth
    if bufferLimit % uintByteWidth > 0 {
        byteSize += 1
    }
    print(UInt.bitWidth)
    var presence = [UInt](repeating: 0, count: byteSize)
    for number in numbers {
        let contIndex = number / UInt.bitWidth
        var container = presence[contIndex]
        let bitIndex = number % UInt.bitWidth
        let mask: UInt = 1 << bitIndex
        container = container | mask
        presence[contIndex] = container
    }
    
    for containerIndex in 0..<presence.count {
        for bitIndex in 0..<UInt.bitWidth {
            let mask: UInt = 1 << bitIndex
            if (presence[containerIndex] & mask) == 0 {
                let missingNumber = containerIndex * UInt.bitWidth + bitIndex
                if missingNumber >= numbersCount {
                    return nil
                } else {
                    return missingNumber
                }
            }
        }
    }
    return nil
}

let numbers = createNumbers()
print("Numbers: ")
print(numbers)
if let missingNumber = findMissingNumber(numbers: numbers) {
    print("The first missing number found is \(missingNumber)")
} else {
    print("There are not missing numbers")
}


