// Missing 2

import Foundation

func squareSum(to: Int) -> Int {
    var sum = 0
    for i in 0...to {
        sum += i * i
    }
    return sum
}

func solve(sum: Int, squareSum: Int) -> (Int, Int) {
    // With the following to equations:
    // x + y = sum
    // x^2 + y^2 = sqrSum
    //We can get a cuadratic equation for x or y:
    // y = sum - x
    // x^2 + (sum -x)^2 - t = 0
    let bSqrd = 4 * pow(Double(sum), 2.0)
    let sqrCom = bSqrd - 8 * (pow(Double(sum), 2.0) - Double(squareSum))
    let sqr = Int(sqrt(sqrCom))
    let x = (2 * sum  + sqr) / 4
    return (x, sum - x)
}

func findMissingNumbers(numbers: [Int]) -> (Int, Int) {
    precondition(numbers.count > 2)
    let n = numbers.count + 2
    let sum = (n * (n + 1)) / 2
    let squaresSum = squareSum(to: n)
    var realSum = 0
    var realSquareSum = 0
    for number in numbers {
        realSum += number
        realSquareSum += number * number
    }
    let mSum = sum - realSum
    let mSquareSum = squaresSum - realSquareSum
    return solve(sum: mSum, squareSum: mSquareSum)
}

let numbers = [1, 2, 4, 5, 6, 7, 8, 9, 10] // missing 3 and 11
let missingNumbers = findMissingNumbers(numbers: numbers)
print("Array: \(numbers)")
print("Missing numbers: \(missingNumbers.0), \(missingNumbers.1)")

