// Remove Dups

import Foundation

class Node<Element> where Element: Comparable {
    let value: Element
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
    
    func removeDuplicates() {
        var pointer: Node? = self
        while let refNode = pointer {
            let checkValue = refNode.value
            var currentNode: Node = refNode
            while let checkNode = currentNode.next {
                if checkNode.value == checkValue {
                    currentNode.next = checkNode.next
                } else {
                    currentNode = checkNode
                }
            }
            pointer = refNode.next
        }
    }
    
    func printList() {
        var currentNode: Node? = self
        while let node = currentNode {
            print("value: \(node.value)")
            currentNode = node.next
        }
    }
}
var head = Node(value: 4)
var lastNode = head
lastNode = lastNode.createNodeAtTail(5)
lastNode = lastNode.createNodeAtTail(4)
lastNode = lastNode.createNodeAtTail(6)
lastNode = lastNode.createNodeAtTail(2)
lastNode = lastNode.createNodeAtTail(2)
lastNode = lastNode.createNodeAtTail(1)
lastNode = lastNode.createNodeAtTail(9)
lastNode = lastNode.createNodeAtTail(2)
lastNode = lastNode.createNodeAtTail(9)
lastNode = lastNode.createNodeAtTail(11)
print("Original list:")
head.printList()
head.removeDuplicates()
print("List with no duplicates:")
head.printList()

