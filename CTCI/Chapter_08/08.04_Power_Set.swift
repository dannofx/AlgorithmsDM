//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Power Set
import Foundation

// First solution

//func calculateSubsets(items: inout Set<Int>) -> [Set<Int>] {
//    var sets = [Set<Int>]()
//    if items.count == 0 {
//        sets.append([])
//        return sets
//    }
//    let prefix = items.removeFirst()
//    let subsets = calculateSubsets(items: &items)
//    for subset in subsets {
//        var incSubset = subset
//        incSubset.insert(prefix)
//        sets.append(incSubset)
//        sets.append(subset)
//    }
//    return sets
//}
//
//func calculateSubsets(_ superset: Set<Int>) -> [Set<Int>] {
//    var items = superset
//    return calculateSubsets(items: &items)
//}


//// Second solution
//
//func calculateSubsets(items: [Int], limit: Int) -> [[Int]] {
//    var sets = [[Int]]()
//    if limit == 0 {
//        sets.append([Int]())
//    } else {
//        let newLimit = limit - 1
//        let value = items[newLimit]
//        var subsets = calculateSubsets(items: items, limit: newLimit)
//        sets.append(contentsOf: subsets)
//        for i in 0..<subsets.count {
//            subsets[i].append(value)
//        }
//        sets.append(contentsOf: subsets)
//    }
//    return sets
//}
//
//
//func calculateSubsets(_ items: [Int]) -> [[Int]] {
//    return calculateSubsets(items: items, limit: items.count)
//}

// Third solution

func convertToSubset(conf: Int, items: [Int]) -> [Int] {
    var subset = [Int]()
    for i in 0..<items.count {
        if (conf & (1 << i)) > 0 {
            subset.append(items[i])
        }
    }
    return subset
}

func calculateSubsets(_ items: [Int]) -> [[Int]]? {
    if items.count >= Int.bitWidth {
        return nil
    }
    var subsets = [[Int]]()
    let max = 1 << items.count
    for i in 0..<max {
        subsets.append(convertToSubset(conf: i, items: items))
    }
    return subsets
}

var items = [1,2,3,4]
if let subsets = calculateSubsets(items) {
    print("Subsets: ")
    for subset in  subsets{
        print(subset)
    }
} else {
    print("Error: Too many items to be calculated")
}


