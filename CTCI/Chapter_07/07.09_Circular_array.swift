//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Circular array

import Foundation

class CircularArray<Element>: Sequence {
    var array: [Element]
    var head: Int
    
    init(withArray array: [Element]) {
        self.array = array
        self.head = 0
    }
    
    init() {
        self.array = [Element]()
        self.head = 0
    }
}

// MARK: - Access to elements
extension CircularArray {
    typealias Iterator = CircularArrayIterator
    struct CircularArrayIterator: IteratorProtocol {
        var circularArray: CircularArray
        var index: Int
        
        init(circularArray: CircularArray) {
            self.circularArray = circularArray
            self.index = 0
        }
        
        mutating func next() -> Element? {
            var next: Element? = nil
            if self.circularArray.count > self.index {
                next = self.circularArray[index]
                index += 1
            }
            return next
        }
        
    }
    
    subscript(index: Int) -> Element {
        get {
            return self.array[self.rIndex(index)]
        }
        set(newValue) {
            self.array[self.rIndex(index)] = newValue
        }
    }
    
    func makeIterator() -> CircularArray<Element>.Iterator {
        return CircularArrayIterator(circularArray: self)
    }
    
}
    
// MARK: - Rotation
extension CircularArray {
    func rotate(_ offset: Int) {
        head = rIndex(offset)
        if head < 0 {
            head = self.count + head
        }
    }
    
    private func rIndex(_ index: Int) -> Int {
        return (head + index) % self.count
    }
}
    
// MARK: - General Methods
extension CircularArray {
    
    func append(_ newElement: Element) {
        if head == 0 {
            self.array.append(newElement)
        } else {
            self.array.insert(newElement, at: head)
            self.rotate(1)
        }
    }
    
    func insert(newElement: Element, at: Int) {
        if at >= self.count {
            print("Error: Array index is out of range")
            return
        }
        let rIndex = self.rIndex(at)
        self.array.insert(newElement, at: rIndex)
        if rIndex < head {
            self.rotate(1)
        }
    }
    
    func remove(at: Int) -> Element{
        return self.array.remove(at: self.rIndex(at))
    }
    
    func removeAll() {
        self.array.removeAll()
        self.head = 0
    }
    
    var count: Int {
        return self.array.count
    }
}


var circularArray = CircularArray(withArray: [5, 4, 3, 2])
circularArray.rotate(-1)
circularArray.append(1)
circularArray.insert(newElement: 10, at: 4)
for item in circularArray {
    print(item)
}
