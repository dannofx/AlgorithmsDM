//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Stack Min

import Foundation

class Stack<Element> {
    var list: StackItem<Element>?
    private(set) var count: Int
    
    class StackItem<Element> {
        private(set) var next: StackItem?
        private(set) var value: Element
        
        init(value: Element, lastItem: StackItem?) {
            self.value = value
            if let lastItem = lastItem {
                self.next = lastItem
            }
        }
    }
    
    init() {
        self.count = 0
    }
    
    func push(_ element: Element) {
        let newItem = StackItem(value: element, lastItem: self.list)
        self.list = newItem
        self.count += 1
    }
    
    func pop() -> Element? {
        if let lastItem = self.list {
            self.list = lastItem.next
            self.count -= 1
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
    
}

class SetOfStacks<Element> {
    private(set) var stacks: Stack<Stack<Element>>
    private(set) var individualLimit: Int
    
    init(individualLimit: Int) {
        self.stacks = Stack<Stack<Element>>()
        self.individualLimit = individualLimit
    }
    
    func push(_ element: Element) {
        if let peekStack = self.stacks.peek(), peekStack.count < individualLimit {
            peekStack.push(element)
        } else {
            let stack = Stack<Element>()
            self.stacks.push(stack)
            stack.push(element)
        }

    }
    
    func pop() -> Element? {
        if let peekStack = self.stacks.peek() {
            let element = peekStack.pop()
            if peekStack.count == 0 {
                _ = self.stacks.pop()
            }
            return element
        } else {
            return nil
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
setOfStacks.push(-2)
setOfStacks.push(15)
setOfStacks.push(16)
print("Count \(setOfStacks.stacks.count)")




