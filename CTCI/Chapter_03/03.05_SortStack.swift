// Sort Stack

import Foundation

protocol StackDelegate {
    associatedtype Element: Comparable
    mutating func push(_ element: Element)
    mutating func pop() -> Element?
    func peek() -> Element?
    func isEmpty() -> Bool
    func toString() -> String
}

class Stack<T: Comparable>: StackDelegate {
    typealias Element = T
    var list: StackItem<Element>?
    var count: Int
    
    class StackItem<Element> {
        var next: StackItem?
        var value: Element
        
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
    
    func isEmpty() -> Bool {
        return self.count == 0
    }
    
    func sort(possibleMin: Element) {
        let auxStack = Stack<Element>()
        while let element = self.pop() {
            while let auxElement = auxStack.peek(), auxElement > element {
                self.push(auxElement)
                _ = auxStack.pop()
            }
            auxStack.push(element)
        }
        while let element = auxStack.pop() {
            self.push(element)
        }
    }
    
    func toString() -> String {
        var current = self.list
        var output = ""
        while current != nil {
            output.append("\(current!.value)\n")
            current =  current!.next
        }
        return output
    }
}


let stack = Stack<Int>()
stack.push(10)
stack.push(8)
stack.push(9)
stack.push(-1)
stack.push(-3)
stack.push(5)
stack.push(4)
stack.push(6)
stack.push(3)
stack.push(1)
stack.push(2)
stack.push(7)
stack.push(0)
stack.push(-2)
stack.sort(possibleMin: Int.min)
print("Sorted elements: \n\(stack.toString())")




