// Find Duplicates
import Foundation

let maxValue = UInt.bitWidth // The max value that can have a number (substract 1 to include 0)
let numbersCount = 500
let bitBufferLimit = UInt.bitWidth // The limit in bits for the buffer used for the solution



func createNumbers() -> [Int] {
    var numbers = [Int]()
    for _ in 0..<numbersCount {
        numbers.append(Int(arc4random()) % maxValue)
    }
    return numbers
}

func printDuplicates(numbers: [Int]) {
    var bitVector = [UInt](repeating: 0, count: bitBufferLimit / UInt.bitWidth)
    if bitBufferLimit % UInt.bitWidth > 0 {
        bitVector.append(0)
    }
    for number in numbers {
        let containerIndex = number / UInt.bitWidth
        let container = bitVector[containerIndex]
        let bitIndex = number % UInt.bitWidth
        let mask: UInt = 1 << bitIndex
        if container & mask != 0 {
            print("\(number)")
        } else {
            bitVector[containerIndex] = container | mask
        }
    }
}

let numbers = createNumbers()
print("All the numbers:")
print(numbers)
print("Duplicates:")
printDuplicates(numbers: numbers)



