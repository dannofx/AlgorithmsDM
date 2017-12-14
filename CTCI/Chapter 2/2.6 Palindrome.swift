// Palindrome

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
    
    func isPalindrome() -> Bool {
        var size = 0
        var isPalindrome = true
        _ = checkPalindrome(node: self, size: &size, isPalindrome: &isPalindrome)
        return isPalindrome
    }
    
    private func checkPalindrome(node: Node, size: inout Int, isPalindrome: inout Bool) -> Node? {
        let currentIndex = size
        size += 1
        guard let nextNode = node.next else {
            return nil
        }
        if let checkNode = checkPalindrome(node: nextNode, size: &size, isPalindrome: &isPalindrome) {
            if isPalindrome && node.value != checkNode.value{
                isPalindrome = false
                return nil
            }
            return checkNode.next
        } else {
            let middleIndex = size / 2
            if currentIndex == middleIndex {
                if size % 2 == 1 {
                    return node.next
                } else {
                    return node
                }
            }
            return nil
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
var head = Node(value: "A")
var lastNode = head
lastNode = lastNode.createNodeAtTail("B")
lastNode = lastNode.createNodeAtTail("N")
lastNode = lastNode.createNodeAtTail("B")
lastNode = lastNode.createNodeAtTail("A")
print("List is palindrome: \(head.isPalindrome())")


