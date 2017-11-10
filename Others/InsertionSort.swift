import Foundation

var elements = [9,0,12,2,3,1,5,6,8,7,11,10,4]

for i in 1..<elements.count {
    let key = elements[i]
    var j = i - 1
    while j >= 0 && key < elements[j] {
        elements[j + 1] = elements[j]
        j -= 1
    }
    elements[j + 1] = key
}
print("Sorted elements \(elements)")
