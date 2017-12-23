// Random Node

import Foundation

class TreeNode<Element: Comparable> {
    let value: Element
    private var left: TreeNode?
    private var right: TreeNode?
    private(set) var size: Int
    
    init(value: Element) {
        self.value = value
        self.size = 1
    }
    
    func insert(_ value: Element) {
        if value <= self.value {
            if let left = self.left {
                left.insert(value)
            } else {
                self.left = TreeNode(value: value)
            }
            
        } else {
            if let right = self.right {
                right.insert(value)
            } else {
                self.right = TreeNode(value: value)
            }
        }
        size += 1
    }
    
    func find(_ value: Element) -> TreeNode? {
        if value == self.value {
            return self
        } else if value <= self.value {
            return self.left?.find(value) ?? nil
            
        } else {
            return self.right?.find(value) ?? nil

        }
    }
    
    func getRandomNode() -> TreeNode {
        let index = Int(arc4random()) % self.size
        return getNode(at: index)!
    }
    
    func getNode(at index: Int) -> TreeNode? {
        if index >= self.size {
            return nil
        }
        let leftSize = self.left?.size ?? 0
        if index < leftSize {
            return self.left!.getNode(at: index)!
        } else if index == leftSize {
            return self
        } else {
            return self.right!.getNode(at: (index - leftSize - 1))!
        }
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
}

let tree = TreeNode(value: 60)
tree.insert(50)
tree.insert(75)
tree.insert(45)
tree.insert(55)
tree.insert(70)
tree.insert(80)
print("Random node: \(tree.getRandomNode().value)")










