// Number max

import Foundation

// Returns 1 for positive and 0 for negative
func getSign(_ n: Int) -> Int {
    return flipBit(abs(n >> (Int.bitWidth - 1)))
}

// Flip the first bit of the number and returns it alone
func flipBit(_ n: Int) -> Int {
    return (1 & n) ^ 1
}

func maxNumber(_ a: Int, _ b: Int) -> Int {
    let signA = getSign(a)
    let signB = getSign(b)
    // If signA and signB differs, signDif is 1, and means overflow risk
    let signDif = signA ^ signB
    // If signs differ, the positive number is the max,
    // otherwise the sign of the difference will indicate
    // the which is bigger. In in the rest a - b, the sign is
    // positive if a is bigger and it's negative if is bigger.
    let fA = signDif * signA + flipBit(signDif) * getSign(a - b)
    let fB = flipBit(fA)
    return a * fA + b * fB
}

let a = 50
let b = 80
let max = maxNumber(a, b)
print("Max(\(a),\(b)): \(max)")
