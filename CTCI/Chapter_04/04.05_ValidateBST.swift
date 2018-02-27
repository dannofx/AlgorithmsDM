//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Validate BST

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
    var value: Element
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

// MARK: Check BST

extension TreeNode {
    
    var isBST: Bool {
        if let left = self.left {
            if left.value > self.value {
                return false
            }
        }
        if let right = self.right {
            if right.value <= self.value {
                return false
            }
        }
        return ( self.left?.isBST ?? true ) && ( self.right?.isBST ?? true )
    }
}



var elements = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
let tree = TreeNode<Int>.createSearchTree(elements: elements)!
tree.left!.left!.value = 2
print("Is binary search tree? \(tree.isBST)")


