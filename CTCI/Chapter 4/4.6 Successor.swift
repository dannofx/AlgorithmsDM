// Successor

import Foundation

public extension Array where Element: Comparable {
    func uniqueSort() -> [Element] {
        var sorted = self.sorted()
        var result = [Element]()
        for i in 0..<sorted.count {
            if i > 0 && sorted[i - 1] == sorted[i] {
                continue
            }
            result.append(sorted[i])
        }
        return result
    }
}

class TreeNode<Element: Comparable> {
    let value: Element
    var left: TreeNode?
    var right: TreeNode?
    weak var parent: TreeNode?
    
    init(value: Element, parent: TreeNode?) {
        self.value = value
        self.parent = parent
    }
}

// MARK: Create tree from array

extension TreeNode {
    
    private class func createSearchTree(elements: [Element], start: Int, end: Int, parent: TreeNode?) -> TreeNode? {
        if start == end {
            return nil
        }
        let middle = start + ( end - start) / 2
        let node = TreeNode(value: elements[middle], parent: parent)
        node.left = createSearchTree(elements: elements, start: start, end: middle, parent: node)
        node.right = createSearchTree(elements: elements, start: middle + 1, end: end, parent: node)
        return node
    }
    
    class func createSearchTree(elements unsortedElements: [Element]) -> TreeNode? {
        let elements = unsortedElements.uniqueSort()
        return createSearchTree(elements: elements, start: 0, end: elements.count, parent: nil)
    }
}

// MARK: Print tree

extension TreeNode {
    
    private func print(parentValue: Element) {
        Swift.print("(\(parentValue))\(self.value)")
        if let left = self.left {
            left.print(parentValue: self.value)
        }
        if let right = self.right {
            right.print(parentValue: self.value)
        }
    }
    
    func print() {
        Swift.print(self.value)
        if let left = self.left {
            left.print(parentValue: self.value)
        }
        if let right = self.right {
            right.print(parentValue: self.value)
        }
    }
}

// MARK: Find next node

extension TreeNode {
    
    private var leftMostNode: TreeNode? {
        return self.left?.leftMostNode ?? self
    }
    
    private var firstLeftChildParent: TreeNode? {
        var node = self
        while let parent = node.parent {
            if parent.left === node {
                return parent
            } else {
                node = parent
            }
        }
        return nil
    }
    
    var inOrderSuccessor: TreeNode? {
        if let right = self.right {
            return right.leftMostNode
        }
        if let parent = self.parent {
            if parent.left === self{
                return parent
            }
            return self.firstLeftChildParent
        }
        return nil
    }
}



var elements = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
let tree = TreeNode<Int>.createSearchTree(elements: elements)!
let node = tree.left!.right!.right!
print("Successor for \(node.value): \(node.inOrderSuccessor?.value ?? Int.min)")


