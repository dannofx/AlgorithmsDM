// Diving Board

import Foundation

enum Plank: Int {
    case big = 4
    case small = 2
}

//// MARK: Memoization methos
//
//func processDivingBoardLengths(k: Int, length: Int, lengths: inout [Int], visited: inout Set<String>) {
//    let key = "\(k) \(length)"
//    if visited.contains(key) {
//        return
//    }
//    visited.insert(key)
//    if k == 0 {
//        lengths.append(length)
//        return
//    } else {
//        processDivingBoardLengths(k: k - 1, length: length + Plank.big.rawValue, lengths: &lengths, visited: &visited)
//        processDivingBoardLengths(k: k - 1, length: length + Plank.small.rawValue, lengths: &lengths, visited: &visited)
//    }
//
//}
//
//func getDivingBoardLengths(k: Int) -> [Int] {
//    precondition(k >= 0)
//    var lengths = [Int]()
//    var visited = Set<String>()
//    processDivingBoardLengths(k: k, length: 0, lengths: &lengths, visited: &visited)
//    return lengths
//}

// MARK: Optimized method

func getDivingBoardLengths(k: Int) -> [Int] {
    precondition(k >= 0)
    var lengths = [Int]()
    for lastBig in 0...k {
        let length = Plank.big.rawValue * lastBig + Plank.small.rawValue * (k - lastBig)
        lengths.append(length)
    }
    return lengths
}

let k = 5
let allLengths = getDivingBoardLengths(k: k)
print("All posible lengths for a diving board of \(k) planks:")
print(allLengths)




