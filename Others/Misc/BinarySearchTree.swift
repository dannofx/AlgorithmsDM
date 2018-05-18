import Foundation

class TreeNode<T: Comparable> {
  var value: T
  var count: Int
  var leftNode: TreeNode<T>?
  var rightNode: TreeNode<T>?
  
  init(value: T) {
    self.value = value
    self.count = 1
  }
  
  func insert(_ value: T) {
    self.count += 1
    if value < self.value {
      if let leftNode = self.leftNode {
        leftNode.insert(value)
      } else {
        self.leftNode = TreeNode(value: value)
      }
    } else {
      if let rightNode = self.rightNode {
        rightNode.insert(value)
      } else {
        self.rightNode = TreeNode(value: value)
      }    
    }
  }
  
  func find(_ value: T) -> TreeNode? {
    if value == self.value {
      return self
    } else if value < self.value {
      if let leftNode = self.leftNode {
        return leftNode.find(value)
      } else {
        return nil
      }    
    } else {
      if let rightNode = self.rightNode {
        return rightNode.find(value)
      } else {
        return nil
      }
    }
  }
  
  func deleteAndReplace(_ value: T) -> (success: Bool, replacement: TreeNode?) {
    if value < self.value {
      // Smaller value
      guard let result = self.leftNode?.deleteAndReplace(value) else {
        return (false, self)
      }
      if result.success {
        self.count -= 1
      }
      self.leftNode = result.replacement
      return (result.success, self)
    } else if value > self.value{
      // Greater value
      guard let result = self.rightNode?.deleteAndReplace(value) else {
        return (false, self)
      }
      if result.success {
        self.count -= 1
      }
      self.rightNode = result.replacement
      return (result.success, self)
    }
    // The value is found
    return (true, self.deleteAndReplace())
  }
}

private extension TreeNode {
  
  func findSmallest() -> TreeNode {
    if let leftNode = self.leftNode {
      return leftNode.findSmallest()
    }
    return self
  }
  
  func deleteAndReplace() -> TreeNode? {
        guard let _ = self.leftNode else {
      // Will be replaced by right node
      let rightNode = self.rightNode
      self.rightNode = nil
      self.count = 1
      return rightNode
    }
    guard let rightNode = self.rightNode else {
      // Will be replaced by left node
      self.count = 1
      return self.leftNode
    }
    // Need to find a kid replacement
    let replacement = rightNode.findSmallest()
    self.rightNode = self.deleteAndReplace(replacement.value).replacement
    self.count -= 1
    self.value = replacement.value
    return self
  }
  
}


class Tree<T: Comparable> {
  private(set) var root: TreeNode<T>?
  
  func insert(_ value: T) {
    if let root = self.root {
      root.insert(value)
    } else {
      self.root = TreeNode(value: value)
    }
  }
  
  func find(_ value: T) -> Bool {
    if let root = self.root {
      return root.find(value) != nil
    } else {
      return false
    }
  }
  
  func delete(_ value: T) -> Bool {
    if let root = self.root {
      let result = root.deleteAndReplace(value)
      self.root = result.replacement
      return result.success
    } else {
      return false
    }
  }
}

let tree = Tree<Int>()
tree.insert(1)
tree.insert(2)
tree.insert(3)
tree.insert(4)
tree.insert(5)
tree.insert(6)
tree.insert(7)
tree.insert(8)
let result = tree.delete(5)
print("Deleted \(result)")
print(tree.find(5))