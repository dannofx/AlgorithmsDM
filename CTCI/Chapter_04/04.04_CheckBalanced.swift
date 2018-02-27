//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Check Balanced

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
}

// MARK: Create tree from array

extension TreeNode {
    
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

// MARK: Check Balanced

extension TreeNode {
    
    // Breadth first search solution
//    var isBalanced: Bool {
//        var pending = [self]
//        var lastLevel = false
//        while pending.count != 0 {
//            var children = [TreeNode<Element>]()
//            for node in pending {
//                if let left = node.left {
//                    if lastLevel {
//                        return false
//                    }
//                    children.append(left)
//                }
//                if let right = node.right {
//                    if lastLevel {
//                        return false
//                    }
//                    children.append(right)
//                }
//            }
//            if pending.count * 2 != children.count {
//                lastLevel = true
//            }
//            pending = children
//        }
//        return true
//    }
    
    private var balancedHeight: Int {
        var leftHeight = 0
        var rightHeight = 0
        if let left = self.left {
            leftHeight = left.balancedHeight
            if leftHeight == -1 {
                return -1
            }
        }
        if let right = self.right {
            rightHeight = right.balancedHeight
            if rightHeight == -1 {
                return -1
            }
        }
        if leftHeight == -1 || rightHeight == -1 {
            return -1
        }
        if abs(leftHeight - rightHeight) > 1 {
            return -1
        } else {
            return max(leftHeight, rightHeight) + 1
        }
    }
    
    var isBalanced: Bool {
        return self.balancedHeight != -1
    }
}



let elements = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
let tree = TreeNode<Int>.createSearchTree(elements: elements)!
tree.right!.right = nil

print("Tree is balanced: \(tree.isBalanced)")


