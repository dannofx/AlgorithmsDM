//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Sum Lists

import Foundation

enum NodeError : Error {
    case invalidValue
}

class Node {
    var value: Int
    var next: Node?
    
    init(value: Int) throws {
        self.value = value
        if value < 0 || value > 9 {
            throw NodeError.invalidValue
        }
    }
    
    func createNodeAtTail(_ value: Int) throws -> Node{
        let newNode = try Node(value: value)
        var currentNode = self
        while let nextNode = currentNode.next {
            currentNode = nextNode
        }
        currentNode.next = newNode
        return newNode
    }
    
    var length: Int {
        var currentNode: Node? = self
        var length = 0
        while currentNode != nil {
            length += 1
            currentNode = currentNode!.next
        }
        return length
    }
    
    func printList() {
        var currentNode: Node? = self
        while let node = currentNode {
            print("value: \(node.value)")
            currentNode = node.next
        }
    }
    
//    // MARK: Methods used for a solution that just convert a list to Int and viceversa
//    func getNumber() -> Int {
//        var value = 0
//        var pointer: Node? = self
//        while let currentNode = pointer {
//            value *= 10
//            value += currentNode.value
//            pointer = currentNode.next
//        }
//        return value
//    }
//
//    func createNumberList(_ number: Int) -> Node {
//        if number == 0 {
//            return try! Node(value: 0)
//        }
//        let divisor = 10
//        var remaining = number
//        var currentNode: Node?
//        while remaining > 0 {
//            let newNode = try! Node(value: remaining % divisor)
//            if let currentNode = currentNode {
//                newNode.next = currentNode
//            }
//            currentNode = newNode
//            remaining = remaining / divisor
//
//        }
//        return currentNode!
//    }
    
}

// MARK: Sum of list numbers

func sumNumberLists(_ list1: Node, _ list2: Node) -> Node {
    let len1 = list1.length
    let len2 = list2.length
    var (resultNode, carry) = sumNumberLists(list1: list1, list2: list2, len1: len1, len2: len2, level: 0)
    if carry > 0 {
        let node = try! Node(value: carry)
        node.next = resultNode
        resultNode = node
    }
    return resultNode
}

func sumNumberLists(list1: Node, list2: Node, len1: Int, len2: Int, level: Int) -> (resultNode: Node, carry: Int) {
    var value = 0
    let maxLen = max(len1, len2)
    if level >= ( maxLen - 1 ) {
        value = list1.value + list2.value
        let node = try! Node(value: value % 10)
        value /= 10
        return (node, value)
    }
    let node1: Node!
    let node2: Node!
    if level >= ( maxLen - len1 ) {
        node1 = list1.next!
        value += list1.value
    } else {
        node1 = list1
    }
    if level >= ( maxLen - len2 ) {
        node2 = list2.next!
        value += list2.value
    } else {
        node2 = list2
    }
    let (postNode, carry) = sumNumberLists(list1: node1, list2: node2, len1: len1, len2: len2, level: level + 1)
    value += carry
    let resultNode = try! Node(value: value % 10)
    resultNode.next = postNode
    return (resultNode, value / 10)
}

// MARK: Sum of inverted list numbers

func sumInvertedNumberLists(_ list1: Node, _ list2: Node) -> Node {
    return sumInvertedNumberLists(list1, list2, 0)!
}

func sumInvertedNumberLists(_ list1: Node?, _ list2: Node?, _ carry: Int) -> Node? {
    if list1 == nil && list2 == nil {
        if carry == 0 {
            return nil
        } else {
            return try! Node(value: carry)
        }
    }
    let value = ( list1?.value ?? 0 ) + ( list2?.value ?? 0) + carry
    let currentNode = try! Node(value: value % 10 )
    currentNode.next = sumInvertedNumberLists(list1?.next, list2?.next, value / 10 )
    return currentNode
}

// Tests
//617 295 = 912
do {
    // Decreasing value node order
    var firstNumber = try Node(value: 6)
    var lastNode = firstNumber
    lastNode = try lastNode.createNodeAtTail(1)
    lastNode = try lastNode.createNodeAtTail(7)
    var secondNumber = try Node(value: 2)
    lastNode = secondNumber
    lastNode = try lastNode.createNodeAtTail(9)
    lastNode = try lastNode.createNodeAtTail(5)
    var result = sumNumberLists(firstNumber, secondNumber)
    print("Result list:")
    result.printList()
    // Increasing value node order
    firstNumber = try Node(value: 7)
    lastNode = firstNumber
    lastNode = try lastNode.createNodeAtTail(1)
    lastNode = try lastNode.createNodeAtTail(6)
    secondNumber = try Node(value: 5)
    lastNode = secondNumber
    lastNode = try lastNode.createNodeAtTail(9)
    lastNode = try lastNode.createNodeAtTail(2)
    result = sumInvertedNumberLists(firstNumber, secondNumber)
    print("Result inverted list:")
    result.printList()
    
} catch NodeError.invalidValue {
    print("Invalid value used to create a node")
}


