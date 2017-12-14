// Delete Middle Node

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
    
    func deleteFromListMiddle() {
        if let nextNode = self.next {
            self.value = nextNode.value
            self.next = nextNode.next
        } else {
            print("Error: The node isn't a middle node!")
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
var head = Node(value: 66)
var lastNode = head
lastNode = lastNode.createNodeAtTail(5)
lastNode = lastNode.createNodeAtTail(4)
lastNode = lastNode.createNodeAtTail(6)
lastNode = lastNode.createNodeAtTail(2)
lastNode = lastNode.createNodeAtTail(23)
lastNode = lastNode.createNodeAtTail(1)
var deleteNode = lastNode
lastNode = lastNode.createNodeAtTail(9)
lastNode = lastNode.createNodeAtTail(12)
lastNode = lastNode.createNodeAtTail(91)
lastNode = lastNode.createNodeAtTail(11)
print("List before delete \(deleteNode.value):")
head.printList()
deleteNode.deleteFromListMiddle()
print("List after delete \(deleteNode.value):")
head.printList()

