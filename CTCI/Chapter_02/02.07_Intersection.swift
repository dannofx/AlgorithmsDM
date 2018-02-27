// Insersection

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
    
    func getTail() -> (tail: Node, index: Int) {
        var len = 0
        var lastNode = self
        while let next = lastNode.next {
            len += 1
            lastNode = next
        }
        return (lastNode, len)
    }
    
    func getIntersection(_ list: Node) -> Node? {
        let list1 = self
        let list2 = list
        var (node1, index1) = list1.getTail()
        var (node2, index2) = list2.getTail()
        if node1 !== node2 {
            return nil
        }
        let lastIndex = max(index1, index2)
        index1 = index1 - lastIndex
        index2 = index2 - lastIndex
        node1 = list1
        node2 = list2
        while index1 != lastIndex && index2 != lastIndex {
            if index1 >= 0 && index2 >= 0 {
                if node1 === node2 {
                    return node1
                }
            }
            if index1 >= 0 {
                node1 = node1.next!
            }
            if index2 >= 0 {
                node2 = node2.next!
            }
            index1 += 1
            index2 += 1
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
var list1 = Node(value: 1)
var lastNode = list1
lastNode = lastNode.createNodeAtTail(2)
lastNode = lastNode.createNodeAtTail(3)
lastNode = lastNode.createNodeAtTail(4)
lastNode = lastNode.createNodeAtTail(10)
var intersection: Node<Int>? //lastNode
lastNode = lastNode.createNodeAtTail(11)
lastNode = lastNode.createNodeAtTail(12)
var list2 = Node(value: 5)
lastNode = list2
lastNode = lastNode.createNodeAtTail(6)
lastNode = lastNode.createNodeAtTail(7)
lastNode = lastNode.createNodeAtTail(8)
lastNode = lastNode.createNodeAtTail(9)
lastNode.next = intersection
print("List 1:")
list1.printList()
print("List 2:")
list2.printList()
if let intersection = list1.getIntersection(list2) {
    print("Intersection in lists: \(intersection.value)")
} else {
    print("There is no intersection in the lists")
}


