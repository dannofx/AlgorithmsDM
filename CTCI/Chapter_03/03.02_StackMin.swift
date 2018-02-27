// Stack Min

import Foundation

struct Stack<Element> where Element: Comparable {
    var list: StackItem<Element>?
    
    class StackItem<Element> where Element: Comparable{
        private(set) var next: StackItem?
        private weak var minItem: StackItem?
        private(set) var value: Element
        
        init(value: Element, lastItem: StackItem?) {
            self.value = value
            if let lastItem = lastItem {
                self.minItem = value > lastItem.minValue ? lastItem.minItem : self
                self.next = lastItem
            } else {
                self.minItem = self
            }
        }
        
        var minValue: Element {
            return self.minItem!.value
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
    
    mutating func min() -> Element? {
        if let lastItem = self.list {
            return lastItem.minValue
        } else {
            return nil
        }
    }
}

var stack = Stack<Int>()
stack.push(1)
stack.push(2)
stack.push(3)
stack.push(4)
stack.push(5)
stack.push(6)
stack.push(-2)
stack.push(15)
_ = stack.pop()
_ = stack.pop()
print("Min: \(stack.min()!)")


