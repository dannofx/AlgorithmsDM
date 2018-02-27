//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Stack Min

import Foundation

protocol StackDelegate {
    associatedtype Element: Comparable
    mutating func push(_ element: Element)
    mutating func pop() -> Element?
    func peek() -> Element?
}

struct Stack<T: Comparable>: StackDelegate {
    typealias Element = T
    var list: StackItem<Element>?
    
    class StackItem<Element> where Element: Comparable{
        private(set) var next: StackItem?
        private(set) var value: Element
        
        init(value: Element, lastItem: StackItem?) {
            self.value = value
            self.next = lastItem
        }
    }
    
    mutating func push(_ element: Element) {
        let newItem = StackItem(value: element, lastItem: self.list)
        self.list = newItem
    }
    
    mutating func pop() -> Element? {
        if let lastItem = self.list {
            self.list = lastItem.next
            return lastItem.value
        } else {
            return nil
        }
    }
    
    func peek() -> Element? {
        return self.list?.value
    }
}

struct MinStack<T: Comparable>: StackDelegate {
    typealias Element = T
    private var stack: Stack<Element>
    private var minStack: Stack<Element>
    
    init() {
        stack = Stack<Element>()
        minStack = Stack<Element>()
    }
    
    mutating func push(_ element: Element) {
        self.stack.push(element)
        if let minElement = minStack.peek() {
            if minElement >= element {
                minStack.push(element)
            }
        } else {
            minStack.push(element)
        }
    }
    
    mutating func pop() -> Element? {
        if let popElement = self.stack.pop() {
            if let minElement = self.minStack.peek(), minElement == popElement {
                _ = self.minStack.pop()
            }
            return popElement
        } else {
            return nil
        }
    }
    
    func peek() -> Element? {
        return self.stack.peek()
    }
    
    func min() -> Element? {
        return self.minStack.peek()
    }
    
}

var stack = MinStack<Int>()
stack.push(1)
stack.push(2)
stack.push(3)
stack.push(4)
stack.push(5)
stack.push(6)
stack.push(-2)
stack.push(-4)
_ = stack.pop()
_ = stack.pop()
print("Min: \(stack.min()!)")


