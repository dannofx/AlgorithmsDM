// Stack Of Plates

import Foundation

protocol StackDelegate {
    associatedtype Element
    mutating func push(_ element: Element)
    mutating func pop() -> Element?
    func peek() -> Element?
    func toString() -> String
}

class Stack<T>: StackDelegate {
    typealias Element = T
    var list: StackItem<Element>?
    var count: Int
    var bottom: StackItem<Element>?
    
    class StackItem<Element> {
        var above: StackItem?
        var below: StackItem?
        var value: Element
        
        init(value: Element, lastItem: StackItem?) {
            self.value = value
            if let lastItem = lastItem {
                self.below = lastItem
                lastItem.above = self
            }
        }
    }
    
    init() {
        self.count = 0
    }
    
    func push(_ element: Element) {
        let newItem = StackItem(value: element, lastItem: self.list)
        self.list = newItem
        if self.count == 0 {
            self.bottom = newItem
        }
        self.count += 1
    }
    
    func pop() -> Element? {
        if let lastItem = self.list {
            self.list = lastItem.below
            self.list?.above = nil
            self.count -= 1
            if self.count == 0 {
                self.bottom = nil
            }
            return lastItem.value
        } else {
            return nil
        }
    }
    
    func peek() -> Element? {
        if let lastItem = self.list {
            return lastItem.value
        } else {
            return nil
        }
    }
    
    func toString() -> String {
        var current = self.list
        var output = ""
        while current != nil {
            output.append("\(current!.value)\n")
            current =  current!.below
        }
        return output
    }
    
    func removeBottom() -> Element? {
        guard let removeNode = self.bottom else {
            return nil
        }
        self.count -= 1
        if let newBottom = removeNode.above {
            newBottom.below = nil
            self.bottom = newBottom
        } else {
            self.bottom = nil
            self.list = nil
        }
        removeNode.above = nil
        removeNode.below = nil
        return removeNode.value
    }
    
}

class SetOfStacks<T>: StackDelegate {
    typealias Element = T
    private(set) var stacks: [Stack<Element>]
    private(set) var individualLimit: Int
    
    init(individualLimit: Int) {
        self.stacks = [Stack<Element>]()
        self.individualLimit = individualLimit
    }
    
    func push(_ element: Element) {
        if let peekStack = self.stacks.last, peekStack.count < individualLimit {
            peekStack.push(element)
        } else {
            let stack = Stack<Element>()
            self.stacks.append(stack)
            stack.push(element)
        }
        
    }
    
    func pop() -> Element? {
        if let peekStack = self.stacks.last {
            let element = peekStack.pop()
            if peekStack.count == 0 {
                stacks.removeLast()
            }
            return element
        } else {
            return nil
        }
    }
    
    func peek() -> Element? {
        if let peekStack = self.stacks.last {
            return peekStack.peek()
        } else {
            return nil
        }
    }
    
    func toString() -> String {
        var output = ""
        for i in 0..<self.stacks.count {
            output.append("Stack number \(i):\n")
            output.append(self.stacks[i].toString())
        }
        return output
    }
    
    func pop(atIndex index: Int) -> Element? {
        if index >= self.stacks.count {
            return nil
        }
        let stack = self.stacks[index]
        guard let returnElement = stack.pop() else {
            return nil
        }
        self.shift(fromIndex: index)
        return returnElement
    }
    
    private func shift(fromIndex index: Int) {
        if index >= (self.stacks.count - 1) {
            return
        }
        let nextIndex = index + 1
        let belowStack = self.stacks[index]
        let aboveStack = self.stacks[nextIndex]
        guard let middleValue = aboveStack.removeBottom() else {
            self.stacks.remove(at: nextIndex)
            return
        }
        belowStack.push(middleValue)
        if aboveStack.count == 0 {
            self.stacks.remove(at: nextIndex)
        } else {
            self.shift(fromIndex: nextIndex)
        }
    }
    
}

var setOfStacks = SetOfStacks<Int>(individualLimit: 4)
setOfStacks.push(1)
setOfStacks.push(2)
setOfStacks.push(3)
setOfStacks.push(4)
setOfStacks.push(5)
setOfStacks.push(6)
setOfStacks.push(7)
setOfStacks.push(8)
setOfStacks.push(9)
setOfStacks.push(10)
setOfStacks.push(11)
setOfStacks.push(12)
setOfStacks.push(13)


print("==")
print("\(setOfStacks.toString())")
_ = setOfStacks.pop(atIndex: 0)
print("==")
print("\(setOfStacks.toString())")
