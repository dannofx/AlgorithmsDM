// BiNode

import Foundation

// MARK: - Node structure

class BiNode {
    var node1: BiNode?
    var node2: BiNode?
    let data: Int
    
    init(_ data: Int) {
        self.data = data
    }
}

// MARK: - Create tree from array

extension BiNode {
    
    private class func createSearchTree(elements: [Int], start: Int, end: Int) -> BiNode? {
        if start == end {
            return nil
        }
        let middle = start + ( end - start) / 2
        let node = BiNode(elements[middle])
        node.node1 = createSearchTree(elements: elements, start: start, end: middle)
        node.node2 = createSearchTree(elements: elements, start: middle + 1, end: end)
        return node
    }
    
    class func createSearchTree(elements unsortedElements: [Int]) -> BiNode {
        precondition(unsortedElements.count > 0)
        let elements = unsortedElements.sorted()
        return createSearchTree(elements: elements, start: 0, end: elements.count)!
    }
}

// MARK: - Problem

func concat(previous: BiNode, next: BiNode) {
    previous.node2 = next
    next.node1 = previous
}

func convertBSTToList(node: BiNode) -> (head: BiNode, tail: BiNode) {
    var head = node
    var tail = node
    if let node1 = node.node1 {
        let prevList = convertBSTToList(node: node1)
        concat(previous: prevList.tail, next: node)
        head = prevList.head
    }
    if let node2 = node.node2 {
        let nextList = convertBSTToList(node: node2)
        concat(previous: node, next: nextList.head)
        tail = nextList.tail
    }
    return (head, tail)
}

// MARK: - Print results

func printList(node: BiNode, forward: Bool) {
    var currentNode: BiNode? = node
    while currentNode != nil {
        print(currentNode!.data)
        currentNode = forward ? currentNode?.node2 : currentNode?.node1
    }
}

func printList(list: (head: BiNode, tail: BiNode)) {
    print("Forward list:")
    printList(node: list.head, forward: true)
    print("Backward list:")
    printList(node: list.tail, forward: false)
}

// MARK: - Test
let numbers = [1,2,3,4,5,6,7,8,9,10]
var tree = BiNode.createSearchTree(elements: numbers)
let list = convertBSTToList(node: tree)
printList(list: list)