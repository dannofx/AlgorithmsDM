// Partition

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
    
    func partitionList(middleValue: Element) -> Node {
        var head: Node = self
        var tail: Node = self
        var pointerNode: Node? = self
        while let currentNode = pointerNode {
            pointerNode = currentNode.next
            if currentNode.value < middleValue {
                currentNode.next = head
                head = currentNode
            } else {
                tail.next = currentNode
                tail = currentNode
                tail.next = nil
            }
        }
        return head
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
lastNode = lastNode.createNodeAtTail(9)
lastNode = lastNode.createNodeAtTail(12)
lastNode = lastNode.createNodeAtTail(91)
lastNode = lastNode.createNodeAtTail(11)
print("Original list:")
head.printList()
let x = 6
let partitionList = head.partitionList(middleValue: x)
print("Partition list around \(x):")
partitionList.printList()

