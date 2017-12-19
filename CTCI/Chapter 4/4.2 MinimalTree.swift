// Minimal Tree
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
}

let elements = [9,6,5,4,3,2,1,4,5,6,7,8,5,4,5,8,9,7,5,3,1]
if let tree = TreeNode<Int>.createSearchTree(elements: elements) {
    tree.print()
} else {
    print("No tree :(")
}



