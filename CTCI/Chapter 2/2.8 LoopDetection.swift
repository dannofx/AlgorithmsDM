// Loop Detection

import Foundation

class Node<Element> where Element: Comparable {
    var value: Element
    var next: Node?
    
    init(value: Element) {
        self.value = value
    }
    
    func createNodeAtTail(_ value: Element) -> Node{
        let newNode = Node(value: value)
        var currentNode = self
        while let nextNode = currentNode.next {
            currentNode = nextNode
        }
        currentNode.next = newNode
        return newNode
    }
    
    func detectLoop() -> Node? {
        var slowPointer: Node? = self.next
        var fastPointer: Node? = self.next?.next
        while var slowNode = slowPointer,
              var fastNode = fastPointer {
                if slowNode === fastNode {
                    slowNode = self
                    while slowNode !== fastNode {
                        slowNode = slowNode.next!
                        fastNode = fastNode.next!
                    }
                    return slowNode
                }
                slowPointer = slowNode.next
                fastPointer = fastNode.next?.next
        }
        return nil
    }
    
    func printList() {
        var currentNode: Node? = self
        while let node = currentNode {
            print("value: \(node.value)")
            currentNode = node.next
        }
    }
    
    
}
var list = Node(value: 1)
var lastNode = list
lastNode = lastNode.createNodeAtTail(2)
lastNode = lastNode.createNodeAtTail(3)
lastNode = lastNode.createNodeAtTail(4)
lastNode = lastNode.createNodeAtTail(5)
var loopNode: Node<Int>?// = lastNode
lastNode = lastNode.createNodeAtTail(6)
lastNode = lastNode.createNodeAtTail(7)
lastNode = lastNode.createNodeAtTail(8)
lastNode = lastNode.createNodeAtTail(9)
lastNode = lastNode.createNodeAtTail(10)
lastNode = lastNode.createNodeAtTail(11)
lastNode.next = loopNode
if let found = list.detectLoop() {
    print("Loop node: \(found.value)")
} else {
    print("There is no loop in the list")
}

