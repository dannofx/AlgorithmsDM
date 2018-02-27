//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Continuos median

import Foundation

// MARK: - Heap

struct Heap<T: Comparable> {
    private var items: [T]
    let isMaximum: Bool
    
    init(maximum: Bool) {
        self.items = [T]()
        self.isMaximum = maximum
    }
    
    mutating func insert(_ element: T) {
        items.append(element)
        let index = items.count - 1
        self.bubbleUp(index: index)
    }
    
    func peekTop() -> T? {
        return self.items.first
    }
    
    mutating func removeTop() -> T? {
        guard let firstValue = self.items.first else {
            return nil
        }
        let lastValue = self.items.last!
        self.items[0] = lastValue
        self.items.removeLast()
        self.bubbleDown(index: 0)
        return firstValue
    }
    
    var count: Int {
        return self.items.count
    }
}

private extension Heap {
    
    mutating func  bubbleUp(index: Int) {
        if index <= 0 || index >= self.items.count {
            return
        }
        let parent = index / 2
        let indexIsLess = items[parent] > items[index]
        if  indexIsLess != self.isMaximum {
            self.swapElements(aIndex: parent, bIndex: index)
            self.bubbleUp(index: parent)
        }
    }
    
    mutating func  bubbleDown(index: Int) {
        if index < 0 || index >= self.items.count {
            return
        }
        var minIndex = index
        for child in self.childrenIndexes(forIndex: index) {
            let childIsLess = self.items[child] < self.items[minIndex]
            if  childIsLess != self.isMaximum {
                minIndex = child
            }
        }
        if minIndex != index {
            self.swapElements(aIndex: minIndex, bIndex: index)
            self.bubbleDown(index: minIndex)
        }
    }
    
    func childrenIndexes(forIndex index: Int) -> [Int] {
        let rightIndex = (index + 1) * 2
        let leftIndex = rightIndex - 1
        var indexes = [Int]()
        if rightIndex < self.items.count {
            indexes.append(leftIndex)
            indexes.append(rightIndex)
        } else if leftIndex < self.items.count {
            indexes.append(leftIndex)
        }
        return indexes
    }
    
    mutating func swapElements(aIndex a: Int, bIndex b: Int) {
        if a < 0 || b < 0 || a >= items.count || b >= items.count {
            return
        }
        let aux = self.items[a]
        self.items[a] = self.items[b]
        self.items[b] = aux
    }
}

// MARK: - Exercise logic

class MedianTracker {
    private var lowMaxHeap: Heap<Int>
    private var highMinHeap: Heap<Int>
    
    init() {
        self.lowMaxHeap = Heap<Int>(maximum: true)
        self.highMinHeap = Heap<Int>(maximum: false)
    }
    // MARK: My Solution
    
//    func addNumber(_ number: Int) {
//        let highValue = self.highMinHeap.peekTop() ?? Int.min
//        if number > highValue {
//            self.highMinHeap.insert(number)
//        } else {
//            self.lowMaxHeap.insert(number)
//        }
//        let diff = self.lowMaxHeap.count  - self.highMinHeap.count
//        if diff == 2 {
//            let value = self.lowMaxHeap.removeTop()!
//            self.highMinHeap.insert(value)
//        } else if diff == -2 {
//            let value = self.highMinHeap.removeTop()!
//            self.lowMaxHeap.insert(value)
//        }
//    }
//
//    var currentMedian: Double? {
//        guard let lowValue = self.lowMaxHeap.peekTop() else {
//            guard let median = self.highMinHeap.peekTop() else {
//                return nil
//            }
//            return Double(median)
//        }
//        guard let highValue = self.highMinHeap.peekTop() else {
//            guard let median = self.lowMaxHeap.peekTop() else {
//                return nil
//            }
//            return Double(median)
//        }
//        if self.lowMaxHeap.count == self.highMinHeap.count {
//            return Double(lowValue + highValue) / 2
//        } else if self.lowMaxHeap.count > self.highMinHeap.count {
//            return Double(lowValue)
//        } else {
//            return Double(highValue)
//        }
//
//    }
    
    // MARK: Book's solution
    
    func addNumber(_ number: Int) {
        // Always highMinHeap.count >= lowMaxHeap.count
        if self.lowMaxHeap.count == self.highMinHeap.count {
            if let lowValue = self.lowMaxHeap.peekTop(), lowValue > number {
                self.lowMaxHeap.insert(number)
                self.highMinHeap.insert(self.lowMaxHeap.removeTop()!)
            } else {
                self.highMinHeap.insert(number)
            }
        } else {
            if let lowValue = self.lowMaxHeap.peekTop(), lowValue > number {
                self.lowMaxHeap.insert(number)
            } else {
                self.highMinHeap.insert(number)
                self.lowMaxHeap.insert(self.highMinHeap.removeTop()!)
            }
        }
    }
    
    var currentMedian: Double? {
        guard let highValue = self.highMinHeap.peekTop() else {
            return nil
        }
        if self.lowMaxHeap.count == self.highMinHeap.count {
            return Double(highValue + self.lowMaxHeap.peekTop()!) / 2
        } else {
            return Double(highValue)
        }
    }
}

// MARK: - Test

func printMedians(numbers: [Int]) {
    let medianTracker = MedianTracker()
    for number in numbers {
        medianTracker.addNumber(number)
        print("Added \(number) : Median \(medianTracker.currentMedian!)")
    }
}

let numbers = [5,4,6,3,7,2,8,1,9,10,11,12,14]
printMedians(numbers: numbers)

