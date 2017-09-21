// Chapter 7, Exercise 7-1

import Foundation

let input = [0,1,2,3,4,5]
let size = input.count
var openValues = input.filter( { $0 != 0})
var solution = [Int].init(repeating: -1, count: size)
var currentSize = 0
var takenValues = [Int: Bool]()
func createDerangement(_ openValues: [Int]) {
    if currentSize == size {
        print("solution: \(solution)")
        return
    }
    var extraValue: Int?
    if takenValues[currentSize] == nil || takenValues[currentSize] == false {
        extraValue = currentSize
    }
    for i in openValues {
        let elem = input[i]
        solution[currentSize] = elem
        takenValues[elem] = true
        currentSize += 1
        var newOpenValues = openValues.filter({ $0 != elem && $0 != currentSize })
        if let otherValue = extraValue {
            newOpenValues.append(otherValue)
        }
        createDerangement(newOpenValues)
        currentSize -= 1
        takenValues[elem] = false
    }
}
let startTime = CFAbsoluteTimeGetCurrent()
createDerangement(openValues)
let endTime = CFAbsoluteTimeGetCurrent()
print("Total time: \(endTime - startTime)")
