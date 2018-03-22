//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Stack Min

import Foundation

// MARK: Classic Stack

class Stack<T: Comparable> {
    private var items: [T]
    
    init() {
        self.items = [T]()
    }
    
    func push(_ item: T) {
        self.items.append(item)    
    }
    
    func pop() -> T? {
        if self.isEmpty {
            return nil
        } else {
            return self.items.removeLast()        
        }
    }
    
    var peek: T? {
        return self.items.last
    }
    
    var isEmpty: Bool {
        return self.items.count == 0
    }
}

// MARK: Min Stack

class MinStack<T: Comparable>: Stack<T> {
    let minStack: Stack<T>
    
    override init() {
        self.minStack = Stack<T>()
        super.init()
    }
    
    override func push(_ item: T) {
        super.push(item)
        if let minVal = self.minStack.peek {
            if minVal >= item {
                self.minStack.push(item)
            }
        } else {
            self.minStack.push(item)
        }
    }
    
    override func pop() -> T? {
        if let popped = super.pop() {
            guard let minVal = self.minStack.peek else { return popped }
            if popped == minVal {
                _ = self.minStack.pop()
            }
            return popped
        } else {
            return nil
        }
    }
    
    var minVal: T? {
        return self.minStack.peek
    }
}

// MARK: Test

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
print("Min: \(stack.minVal!)")
