// Majority Element

import Foundation

func swap(_ number1: inout Int, _ number2: inout Int) {
    number1 = number1 ^ number2
    number2 = number1 ^ number2
    number1 = number1 ^ number2
}

func findMajorElement(_ array: [Int]) -> Int {
    var majNumber = array[0]
    var maxCount = 0
    var otherNumber = 0
    var otherCount = 0
    for number in array {
        if majNumber == number {
            maxCount += 1
        } else if otherNumber == number {
            otherCount += 1
        } else {
            otherNumber = number
            otherCount = 1
        }
        if otherCount > maxCount {
            swap(&otherCount, &maxCount)
            swap(&otherNumber, &majNumber)
        }
    }
    return majNumber
}

func isMajorityElement(_ element: Int, in array: [Int]) -> Bool {
    let count = array.reduce(0) { result, current in result + (current == element ? 1 : 0) }
    return count > (array.count / 2)
}

func findMajorityElement(_ array: [Int]) -> Int? {
    precondition(array.count > 0)
    let majNumber = findMajorElement(array)
    let isMajority = isMajorityElement(majNumber, in: array)
    return isMajority ? majNumber : nil
}

let numbers = [1, 2, 5, 9, 5, 9, 5, 5, 5]
print("Array: ")
print(numbers)
if let majorityElem = findMajorityElement(numbers) {
    print("Majority element: \(majorityElem)")
} else {
    print("There is no majority element in the array")
}
