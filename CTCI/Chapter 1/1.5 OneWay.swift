// Are One Edit?

import Foundation

func areOneEdit(_ string1: String, _ string2: String) -> Bool {
    if abs(string1.count - string2.count) > 1 {
        return false
    }
    var array1: [Character]!
    var array2: [Character]!
    if string1.count > string2.count {
        array1 = Array(string1)
        array2 = Array(string2)
    } else {
        array1 = Array(string2)
        array2 = Array(string1)
    }
    var editionDetected = false
    var index1 = 0
    var index2 = 0
    while index1 < array1.count{
        if index2 >= array2.count || array1[index1] != array2[index2] {
            if editionDetected {
                return false
            }
            editionDetected = true
            if array1.count == array2.count {
                index2 += 1
            }
        } else {
            index2 += 1
        }
        index1 += 1
    }
    return editionDetected
}

var string1 = ""
var string2 = ""
string1 = "pale"
string2 = "ple"
print("\(string1), \(string2) -> \(areOneEdit(string1, string2))")
string1 = "pales"
string2 = "pale"
print("\(string1), \(string2) -> \(areOneEdit(string1, string2))")
string1 = "pale"
string2 = "bale"
print("\(string1), \(string2) -> \(areOneEdit(string1, string2))")
string1 = "pale"
string2 = "bake"
print("\(string1), \(string2) -> \(areOneEdit(string1, string2))")
string1 = "nnnx"
string2 = "xnnn"
print("\(string1), \(string2) -> \(areOneEdit(string1, string2))")
