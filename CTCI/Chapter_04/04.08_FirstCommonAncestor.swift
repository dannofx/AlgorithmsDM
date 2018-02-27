//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// First Common Ancestor

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
    
    init(value: Element) {
        self.value = value
    }
    
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
    
    private class func createSearchTree(elements: [Element], start: Int, end: Int) -> TreeNode? {
        if start == end {
            return nil
        }
        let middle = start + ( end - start) / 2
        let node = TreeNode(value: elements[middle])
        node.left = createSearchTree(elements: elements, start: start, end: middle)
        node.right = createSearchTree(elements: elements, start: middle + 1, end: end)
        return node
    }
    
    class func createSearchTree(elements unsortedElements: [Element]) -> TreeNode? {
        let elements = unsortedElements.uniqueSort()
        return createSearchTree(elements: elements, start: 0, end: elements.count)
    }
    
    private func getCoveringNode(_ node1: TreeNode, _ node2: TreeNode) -> (coveringNode: TreeNode, isAncestor: Bool)? {
        
        if node1 === self && node2 === self {
            return (self, true)
        }
        let resultLeft = self.left?.getCoveringNode(node1, node2)
        if let resultLeft = resultLeft {
            if resultLeft.isAncestor {
                return resultLeft
            }
        }
        let resultRight = self.right?.getCoveringNode(node1, node2)
        if let resultRight = resultRight {
            if resultRight.isAncestor {
                return resultRight
            }
        }
        if node1 === self || node2 === self {
            if resultLeft != nil || resultRight != nil {
                return (self, true)
            } else {
                return (self, false)
            }
        } else if resultLeft != nil && resultRight != nil {
            return (self, true)
        } else {
            if let result = resultLeft != nil ? resultLeft : resultRight {
                return (result.coveringNode, false)
            } else {
                return nil
            }
        }
    }

    func findCommonAncestor(node1: TreeNode, node2: TreeNode) -> TreeNode? {
        if let result = self.getCoveringNode(node1, node2), result.isAncestor {
            return result.coveringNode
        } else {
            return nil
        }
    }
}

let elements = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
if let tree = TreeNode<Int>.createSearchTree(elements: elements) {
    tree.print()
    let node1 = tree.left!.left!.right!
    let node2 = tree.right!.right!.right!
    if let ancestor = tree.findCommonAncestor(node1: node1, node2: node2) {
        print("Ancestor of \(node1.value) and \(node2.value): \(ancestor.value)")
    } else {
        print("No common ancestor for \(node1.value) and \(node2.value)")
    }
} else {
    print("No tree :(")
}