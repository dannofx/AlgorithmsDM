// Shellsort
import Foundation

var elements = [9,0,12,2,3,1,5,6,8,7,11,10,4]

func shellsort(elements: inout [Int]) {
    let n = elements.count
    var gap = n / 2
    while gap > 0 {
        for i in gap..<n {
            var j = i
            let tmp = elements[j]
            while j >= gap && tmp < elements[j - gap] {
                elements[j] = elements[j - gap]
                j -= gap
            }
            elements[j] = tmp
        }
        gap /= 2
    }
    
}

shellsort(elements: &elements)
print("Sorted elements: \(elements)")

