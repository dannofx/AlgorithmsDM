// Sorted Merge

import Foundation

func merge(in a: inout [Int], from b: [Int], lastA: Int) -> Bool{
    if lastA >= a.count ||
        (a.count - (lastA + 1)) < b.count {
        return false
    }
    var indexA =  lastA
    var indexB = b.count - 1
    var current = a.count - 1
    while indexB >= 0 {
        if indexA >= 0 && a[indexA] == b[indexB] {
            a[current] = a[indexA]
            current -= 1
            indexA -= 1
            a[current] = b[indexB]
            indexB -= 1
        } else if indexA >= 0 && a[indexA] > b[indexB] {
            a[current] = a[indexA]
            indexA -= 1
        } else {
            a[current] = b[indexB]
            indexB -= 1
        }
        current -= 1
    }
    
    return true
}

var a = [1,3,5,7,10,0,0,0,0,0]
var b = [2,4,6,8,10]
let lastA = 4
if merge(in: &a, from: b, lastA: lastA) {
    print("Merged array: \(a)")
} else {
    print("Inout error")
}



