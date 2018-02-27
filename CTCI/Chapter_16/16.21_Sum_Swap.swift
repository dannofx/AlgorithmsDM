// Sum Swap

import Foundation


func findSumSwap(a: [Int], b: [Int]) -> (success: Bool , swap: (a: Int, b: Int)?) {
    let sumA = a.reduce(0) { $0 + $1 }
    let sumB = b.reduce(0) { $0 + $1 }
    let totalSum = sumA + sumB
    if sumA == sumB {
        return (true, nil)
    }
    if totalSum % 2 == 1 {
        return (false, nil)
    }
    let setB = Set<Int>(b)
    for numA in a {
        let neededNumber = (totalSum / 2) + numA - sumA
        if setB.contains(neededNumber) {
            return (true, (numA, neededNumber))
        }
    }
    return (false, nil)
}

let a = [4, 1, 2, 1, 1, 2]
let b = [3, 6, 3, 3]
let res = findSumSwap(a: a, b: b)
print("Array A: \(a)")
print("Array B: \(b)")
if res.success {
    if let swap = res.swap {
        print("Elements to swap: \(swap)")
    } else {
        print("The arrays already have the same sum.")
    }
    
} else {
    print("There are not elements to swap")
}
