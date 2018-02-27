//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Sorted Search, No size

import Foundation

struct Listy {
    private var array: [Int]
    
    init(withArray array: [Int]) {
        self.array = array.sorted()
        self.array = self.array.filter { $0 >= 0 }
    }
    
    subscript(index: Int) -> Int {
        get {
            if index < 0 || index >= array.count {
                return -1
            } else {
                return self.array[index]
            }
        }
        set(newValue) {
            if index >= 0 && index < array.count {
                self.array[index] = newValue
            }
        }
    }
}

func findIndex(value: Int, listy: Listy, first: Int, last: Int) -> Int? {
    if first > last {
        return nil
    }
    let middle = first + (last - first)/2
    if listy[middle] == value {
        return middle
    }
    if listy[first] >= value && listy[middle] > value {
        return findIndex(value: value, listy: listy, first: first, last: middle - 1)
    } else {
        
        return findIndex(value: value, listy: listy, first: middle + 1, last: last)
    }
}

func findIndex(value: Int, listy: Listy, start: Int) -> Int? {
    if listy[start] == -1 {
        return nil
    }
    if listy[start] == value {
        return start
    }
    var current = (start == 0) ? 1 : start * 2
    while listy[current] != -1 {
        if listy[current] >= value {
            return findIndex(value: value, listy: listy, first: current / 2, last: current)
        }
        current *= 2
    }
    return findIndex(value: value, listy: listy, start: current)
}

func findIndex(value: Int, listy: Listy) -> Int? {
    return findIndex(value: value, listy: listy, start: 0)
}

let listy = Listy(withArray: [1,2,3,4,5,6,7,8,9,10])
let value = 5
if let index = findIndex(value: value, listy: listy) {
    print("Index for \(value): \(index)")
} else {
    print("Error: Index for \(value) not found")
}
