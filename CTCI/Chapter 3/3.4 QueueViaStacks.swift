// Queue via Stacks

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

protocol QueueDelegate {
    associatedtype Element
    mutating func add(_ element: Element)
    mutating func remove() -> Element?
    mutating func peek() -> Element?
    func isEmpty() -> Bool
}

struct  StackQueue<T>: QueueDelegate {
    typealias Element = T
    var elements: Stack<Element>
    var firstElements: Stack<Element>
    
    init() {
        self.elements = Stack<Element>()
        self.firstElements = Stack<Element>()
    }
    
    mutating func add(_ element: Element) {
        self.elements.push(element)
    }
    mutating func remove() -> Element? {
        self.moveFirstIfNecessary()
        return self.firstElements.pop()
    }
    mutating func peek() -> Element? {
        self.moveFirstIfNecessary()
        return self.firstElements.peek()
    }
    
    func isEmpty() -> Bool {
        return self.elements.count == 0 && self.firstElements.count == 0
    }
    
    private func moveFirstIfNecessary() {
        if self.elements.count == 0 || self.firstElements.count != 0 {
            return
        }
        while let element = self.elements.pop() {
            self.firstElements.push(element)
        }
    }
    
}

var queue = StackQueue<Int>()
queue.add(1)
queue.add(2)
queue.add(3)
queue.add(4)
queue.add(5)
queue.add(6)
queue.add(7)
queue.add(8)
var element = queue.remove()!
print("Is empty? \(queue.isEmpty())")
print("Removed: \(element)")
element = queue.remove()!
print("Removed: \(element)")
element = queue.remove()!
print("Removed: \(element)")
element = queue.remove()!
print("Removed: \(element)")
element = queue.remove()!
print("Removed: \(element)")
element = queue.remove()!
print("Removed: \(element)")
element = queue.remove()!
print("Removed: \(element)")
element = queue.remove()!
print("Removed: \(element)")
print("Is empty? \(queue.isEmpty())")



