// List of Depths
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

// MARK: List of depths
extension TreeNode {
    
    class ListNode<Element> {
        let value: Element
        var next: ListNode?
        
        init(value: Element) {
            self.value = value
        }
        
        func toString() -> String {
            var res = "\(self.value)"
            if let next = self.next {
                res.append("->")
                res.append(next.toString())
            }
            return res
        }
        
    }

    func createListsOfDepths() -> [ListNode<Element>] {
        var pending = [self]
        var results = [ListNode<Element>]()
        while pending.count != 0 {
            var head: ListNode<Element>? = nil
            var tail: ListNode<Element>? = nil
            var children = [TreeNode<Element>]()
            for i in 0..<pending.count {
                let node = ListNode(value: pending[i].value)
                if head == nil {
                    head = node
                }
                tail?.next = node
                tail = node
                if let left = pending[i].left {
                    children.append(left)
                }
                if let right = pending[i].right {
                    children.append(right)
                }
            }
            pending = children
            results.append(head!)
        }
        return results
    }
}


let elements = [9,6,5,4,3,2,1,4,5,6,7,8,5,4,5,8,9,7,5,3,1,0]
let tree = TreeNode<Int>.createSearchTree(elements: elements)!
let depthsLists = tree.createListsOfDepths()
for list in depthsLists {
    print("\(list.toString())")
}


