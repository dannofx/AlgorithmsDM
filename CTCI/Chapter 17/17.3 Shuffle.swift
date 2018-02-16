// Random Set

import Foundation

extension Array {
    func shuffled() -> [Element] {
        var array = self
        for i in 0..<array.count {
            let j = Int(arc4random()) % array.count
            let temp = array[i]
            array[i] = array[j]
            array[j] = temp
        }
        return array
    }
}

//MARK: - Solution using sets

extension Array where Element: Hashable{
    
    func randomSubset(size: Int) -> Set<Element> {
        precondition(size > 0 && size <= self.count)
        var array = self.shuffled()
        var subset = Set<Element>()
        for i in 0..<size {
            subset.insert(array[i])
        }
        return subset
    }
}

//MARK: - Book's solution

extension Array {
    func randomSubArray(size: Int) -> [Element] {
        precondition(size > 0 && size <= self.count)
        var subarray = Array(self[0..<size])
        for i in subarray.count..<self.count {
            let k = Int(arc4random()) % (i + 1)
            if k < subarray.count {
                subarray[k] = self[i]
            }
        }
        return subarray
    }
    
}
// General tests
let array = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
let size = 4
let subset = array.randomSubset(size: size)
let subarray = array.randomSubArray(size: size)
print("Original array: ")
print(array)
print("Random subset of size \(size): ")
print(subset)
print("Random aubarray of size \(size): ")
print(subarray)

// Test to check fairness of the subarray
var averages = [Int](repeating: 0, count: size)
var times = 0
for _ in 0...1000 {
    let subarray = array.randomSubArray(size: size)
    for i in 0..<subarray.count {
        averages[i] += subarray[i]
    }
    times += 1
}

print("Averages of subarray: ")
print(averages.map { $0 / times })
print("Average of all elements in the original array: ")
print((array.reduce(0){ $0 + $1 }) / array.count)
