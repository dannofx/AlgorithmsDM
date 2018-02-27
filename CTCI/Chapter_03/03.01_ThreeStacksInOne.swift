//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Three in one

import Foundation
class Multistack<Element> {
    let defaultSize: Int
    private(set) var stacks: [SingleStack]
    private var values: [Element]
    
    class SingleStack {
        unowned let multistack: Multistack
        var startIndex: Int
        var availablePosition: Int
        var size: Int
        let stackIndex: Int
        
        init(multistack: Multistack, startIndex: Int, size: Int, stackIndex: Int) {
            self.multistack = multistack
            self.startIndex = startIndex
            self.availablePosition = startIndex
            self.size = size
            self.stackIndex = stackIndex
        }
        
        func push(_ item: Element) -> Bool {
            if self.isFull() {
                let expanded = self.multistack.expandStack(atIndex: self.stackIndex)
                if !expanded {
                    return false
                }
            }
            self.multistack.values[self.availablePosition] = item
            self.availablePosition += 1
            self.adjustIndex(&availablePosition)
            return true
        }
        
        func pop() -> Element? {
            if self.isEmpty() {
                return nil
            } else {
                let element = self.multistack.values[self.availablePosition]
                self.availablePosition -= 1
                self.adjustIndex(&availablePosition)
                return element
            }
        }
        
        var lastIndex: Int {
            var last = self.startIndex + self.size - 1
            self.adjustIndex(&last)
            return last
        }
        
        func isEmpty() -> Bool {
            return self.availablePosition == self.startIndex
        }
        
        func isFull() -> Bool {
            var lastElementIndex = self.availablePosition - 1
            self.adjustIndex(&lastElementIndex)
            return lastElementIndex == self.lastIndex
        }
        
        func shift() {
            let spaceLeft = !self.isFull()
            let end = self.startIndex + self.size
            for i in self.startIndex..<end {
                var prevIndex = i
                var postIndex = i + 1
                self.adjustIndex(&prevIndex)
                self.adjustIndex(&postIndex)
                self.multistack.values[postIndex] = self.multistack.values[prevIndex]
            }
            self.startIndex += 1
            self.adjustIndex(&startIndex)
            self.availablePosition += 1
            self.adjustIndex(&availablePosition)
            if spaceLeft {
                self.size -= 1
            }
        }
        
        private func adjustIndex(_ index: inout Int) {
            if index < 0 {
                index = self.multistack.values.count - index
            } else if index >= self.multistack.values.count {
                index = index - self.multistack.values.count
            }
        }
        
        private func indexForComparison(_ index: Int) -> Int{
            if index < startIndex {
                return self.multistack.values.count + index
            } else {
                return index
            }
        }
        
        func printElements() {
            let end = indexForComparison(self.availablePosition)
            for i in self.startIndex..<end {
                var realIndex = i
                adjustIndex(&realIndex)
                print("i \(realIndex): \(self.multistack.values[realIndex])")
            }
        }
        
    }
    
    init(stacksNumber: Int, defaultSize: Int, defaultValue: Element) {
        self.defaultSize = defaultSize
        self.values = [Element].init(repeating: defaultValue, count: defaultSize * stacksNumber)
        self.stacks = [SingleStack]()
        for i in 0..<stacksNumber {
            let start = i * defaultSize
            let singleStack = SingleStack(multistack: self, startIndex: start, size: defaultSize, stackIndex: i)
            self.stacks.append(singleStack)
        }
    }
    
    func isFull() -> Bool {
        for stack in stacks {
            if !stack.isFull() {
                return false
            }
        }
        return true
    }
    
    private func expandStack(atIndex index: Int) -> Bool{
        if self.isFull() {
            return false
        }
        let expandingStack = self.stacks[index]
        var stackIndex = adjustedStackIndex(index)
        while self.stacks[stackIndex].isFull() {
            stackIndex = adjustedStackIndex(stackIndex + 1)
        }
        
        while stackIndex != index {
            self.stacks[stackIndex].shift()
            stackIndex -= 1
            adjustStackIndex(&stackIndex)
        }
        expandingStack.size += 1
        return true
    }
    
    private func adjustStackIndex(_ index: inout Int) {
        if index < 0 {
            index = self.stacks.count - index
        } else if index >= self.stacks.count {
            index = index - self.stacks.count
        }
    }
    
    private func adjustedStackIndex(_ index: Int) -> Int {
        if index < 0 {
            return self.stacks.count - index
        } else if index >= self.stacks.count {
            return index - self.stacks.count
        } else {
            return index
        }
    }
    
    func printSizes() {
        for i in 0..<self.stacks.count {
            print("Stack \(i): \(self.stacks[i].size)")
        }
    }
    func printStacks() {
        
        for i in 0..<self.stacks.count {
            print(" == Stack \(i): \(self.stacks[i].size)")
            self.stacks[i].printElements()
        }
    }
}

var multistack = Multistack(stacksNumber: 3, defaultSize: 4, defaultValue: 0)

print("====== State (original): ")
multistack.printStacks()
// Op 1
_ = multistack.stacks[0].push(1)
_ = multistack.stacks[0].push(2)
_ = multistack.stacks[0].push(3)
_ = multistack.stacks[1].push(4)
_ = multistack.stacks[1].push(5)
_ = multistack.stacks[1].push(6)
_ = multistack.stacks[2].push(7)
_ = multistack.stacks[2].push(8)
_ = multistack.stacks[2].push(9)
print("====== State (1): ")
multistack.printStacks()
// Op 2
_ = multistack.stacks[0].push(10)
_ = multistack.stacks[0].push(11)
print("====== State (2): ")
multistack.printStacks()
// Op 3
_ = multistack.stacks[1].push(12)
print("====== State (3): ")
multistack.printStacks()
// Op 4
_ = multistack.stacks[0].pop()
_ = multistack.stacks[0].pop()
_ = multistack.stacks[0].pop()
_ = multistack.stacks[0].pop()
_ = multistack.stacks[0].pop()
print("====== State (4): ")
multistack.printStacks()
// Op 5
_ = multistack.stacks[1].push(13)
_ = multistack.stacks[1].push(14)
_ = multistack.stacks[1].push(15)
_ = multistack.stacks[1].push(16)
_ = multistack.stacks[1].push(17)
print("====== State (5): ")
multistack.printStacks()

