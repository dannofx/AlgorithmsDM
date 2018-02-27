//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Random Node

import Foundation

class TreeNode<Element: Comparable> {
    private(set) var value: Element
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
    
    private var biggestLeaf: TreeNode {
        if let right = self.right {
            return right.biggestLeaf
        } else {
            return self
        }
    }
    
    private var smallestLeaf: TreeNode {
        if let left = self.left {
            return left.smallestLeaf
        } else {
            return self
        }
    }
    
    private func deleteChild(_ value: Element) -> TreeNode?{
        var deletedResult: (deleted: TreeNode?, replacement: TreeNode?) = (nil, nil)
        if let left = self.left {
            deletedResult = left.delete(value)
            if let deletedNode = deletedResult.deleted {
                if self.left === deletedNode {
                    self.left = deletedResult.replacement
                }
            }
        }
        
        if let right = self.right, deletedResult.deleted == nil {
            deletedResult = right.delete(value)
            if let deletedNode = deletedResult.deleted {
                if self.right === deletedNode {
                    self.right = deletedResult.replacement
                }
            }
        }
        if deletedResult.deleted != nil {
            self.size -= 1
            return deletedResult.deleted
        } else {
            return nil
        }
    }
    
    func delete(_ value: Element) -> (deleted: TreeNode?, replacement: TreeNode?) {
        if value == self.value {
            self.size -= 1
            if self.right == nil && self.left == nil {
                return (self, nil)
            } else if let right = self.right, self.left == nil {
                return (self, right)
            } else if let left = self.left, self.right == nil {
                return (self, left)
            } else {
                let left = self.left!
                let right = self.right!
                if right.left == nil {
                    right.left = left
                    return (self, right)
                }
                left.biggestLeaf.right = right
                return (self, left)
                
            }
        }
        return (self.deleteChild(value), nil)
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

