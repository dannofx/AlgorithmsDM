// Check Subtree

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
    
    class func treesMatch(_ tree1: TreeNode?, _ tree2: TreeNode?) -> Bool {
        
        if tree1 == nil && tree2 == nil {
            return true
        }
        guard let tree1 = tree1 else {
            return false
        }
        guard let tree2 = tree2 else {
            return false
        }
        if tree1.value != tree2.value {
            return false
        }
        return treesMatch(tree1.left, tree2.left) && treesMatch(tree1.right, tree2.right)
    }
    
    func isSubTree(_ tree: TreeNode) -> Bool{
        if self.value == tree.value && TreeNode.treesMatch(self, tree) {
            return true
        } else {
            return self.left?.isSubTree(tree) ?? false || self.right?.isSubTree(tree) ?? false
        }
    }
    
}

let tree1 = TreeNode(value: 10)
tree1.left = TreeNode(value: 5)
tree1.right = TreeNode(value: 15)
tree1.left!.left = TreeNode(value: 3)
tree1.left!.right = TreeNode(value: 7)
tree1.right!.left = TreeNode(value: 13)
tree1.right!.right = TreeNode(value: 17)

let tree2 = TreeNode(value: 15)
tree2.left = TreeNode(value: 13)
tree2.right = TreeNode(value: 17)

print("Is subtree? \(tree1.isSubTree(tree2))")









