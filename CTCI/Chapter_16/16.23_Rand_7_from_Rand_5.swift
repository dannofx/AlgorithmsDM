// Rand 7 from Rand 5

import Foundation

func rand5() -> UInt32 {
    return arc4random() % 5
}

// MARK: My solution

//func rand2() -> UInt32 {
//    var result: UInt32 = 4
//    while result > 3 {
//        result = rand5()
//    }
//    return result % 2
//}
//
//func rand7() -> UInt32 {
//    var result: UInt32 = 7
//    while result > 6 {
//        result = rand5() + rand2() * 5
//    }
//    return result
//}

// MARK: A better solution

func rand7() -> UInt32 {
    while true {
        let result = 5 * rand5() + rand5() // Has uniform distribution between 0 and 24
        if result < 21 {
            return result % 7
        }
    }
}

// MARK: Tests

let limit = 100000
print("Rand 7 stats (\(limit) tests)")
var results = [Int](repeating: 0, count: 7)
for _ in 0..<limit {
    let res = rand7()
    results[Int(res)] += 1
}
print(results)

