// Search In Rotated Array

import Foundation

// MARK: - Iterative solution

func findIndex(for value: Int, in array: [Int]) -> Int? {
    var first = 0
    var last = array.count - 1
    var pending = [(first: Int, last: Int)]()
    while first <= last || pending.count > 0 {
        if first > last {
            (first, last) = pending.removeLast()
        }
        let middle = first + (last - first) / 2
        if array[middle] == value {
            return middle
        } else {
            if array[middle] == array[last] && array[last] == array[first] {
                if middle == last {
                    last = middle - 1
                } else if middle == first {
                    first = middle + 1
                } else {
                    pending.append((middle + 1, last))
                    last = middle - 1
                }
            } else if value > array[middle] {
                if array[first] > array[middle] && value >= array[first] ||
                   array[first] == array[middle] && value > array[last] {
                    last = middle - 1
                } else {
                    first = middle + 1
                }
            } else {
                if array[last] < array[middle] && value <= array[last] ||
                   array[last] == array[middle] && value < array[first] {
                    first = middle + 1
                } else {
                    last = middle - 1
                }
            }
        }
        
    }
    return nil
}

// MARK: Recursive solution

func rfindIndex(for value: Int, in array: [Int], first: Int, last: Int) -> Int? {
    if first > last {
        return nil
    }
    let middle = first + (last - first) / 2
    if array[middle] == value {
        return middle
    }
    if array[first] < array[middle] {
        // The left part has correct order
        if array[first] <= value && array[middle] > value {
            return rfindIndex(for: value, in: array, first: first, last: middle - 1)
        } else {
            return rfindIndex(for: value, in: array, first: middle + 1, last: last)
        }
    } else if array[first] > array[middle] {
        // The right part has correct order
        if array[last] >= value && array[middle] < value {
            return rfindIndex(for: value, in: array, first: middle + 1, last: last)
        } else {
            return rfindIndex(for: value, in: array, first: first, last: middle - 1)
        }
        
    } else {
        // In this case the left part is full of duplicated numbers
        if array[last] > array[middle] {
            // Regardless the duplicated numbers in the left the right
            // part has correct order, so it can be used to continue the
            // search.
            return rfindIndex(for: value, in: array, first: middle + 1, last: last)
        } else {
            // Both ends of the array has duplicated numbers.
            // The number could sorrounded of duplicated elements,
            // so the search is performed in both parts.
            if let index = rfindIndex(for: value, in: array, first: middle + 1, last: last) {
                return index
            } else {
                return rfindIndex(for: value, in: array, first: first, last: middle - 1)
            }
        }
    }

}
func rfindIndex(for value: Int, in array: [Int]) -> Int? {
    return rfindIndex(for: value, in: array, first: 0, last: array.count - 1)
}


//let input = [12,13,14,15,16,1,2,3,4,5,6,7,8,9,10,11]
//let input = [12,13,14,15,16,2,2,2,2,2,2,2,2,2,2,2,2,2]
//let input = [2,2,2,2,2,2,2,2,2,2,2,2,2,14,-3,-2,-1,0,1]
//let input = [2,2,12,13,14,15,16,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2]
//let input = [2,2,2,2,2,2,2,2,2,2,14,2,2,2]
//let input = [2,2,2,2,14,2]
let input = [2,2,2,14,2,2,2,2,2,2,2,2,2,2]
let value = 14
if let index = rfindIndex(for: value, in: input) {
    print("Index of \(value): \(index)")
} else {
    print("Error: Value \(value) not found")
}
