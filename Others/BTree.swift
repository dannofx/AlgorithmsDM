// B-Tree

// MARK: BTree node class

class BTreeNode<Element> where Element: Comparable {
    var keys: [Element]
    var children: [BTreeNode]
    var degree: Int
    var leaf: Bool
    
    init(degree: Int, leaf: Bool) {
        self.degree = degree
        self.leaf = leaf
        self.keys = [Element]()
        self.children = [BTreeNode]()
    }
    
    func traverse() {
        for (i, key) in self.keys.enumerated() {
            if !self.leaf {
                self.children[i].traverse()
            }
            print("\(key) ")
        }
        if !self.leaf {
            self.children[self.keys.count].traverse()
        }
    }
    
    func search(_ searchItem: Element) -> BTreeNode?{
        var i = 0
        while i < self.keys.count && searchItem > self.keys[i] {
            i += 1
        }
        if i < self.keys.count && self.keys[i] == searchItem {
            return self
        }
        if self.leaf {
            return nil
        }
        return children[i].search(searchItem)
    }
    
    func insertNonFull(_ item: Element) {
        if self.leaf {
            // The node is leaf,
            // just look for the correct space for the insertion
            var insertionIndex = self.keys.count
            for i in stride(from: self.keys.count - 1, through: 0, by: -1) {
                if self.keys[i] < item{
                    break
                } else {
                    insertionIndex = i
                }
            }
            self.keys.insert(item, at: insertionIndex)
        } else {
            // This node is no leaf
            // Look for the correct space
            var insertionIndex = self.keys.count
            for i in stride(from: self.keys.count - 1, through: 0, by: -1) {
                if self.keys[i] < item{
                    break
                } else {
                    insertionIndex = i
                }
            }
            
            // Split the child if necessary
            if self.children[insertionIndex].keys.count == (2 * self.degree - 1) {
                self.splitChild(insertionIndex, oldNode: self.children[insertionIndex])
                if self.keys[insertionIndex] < item {
                    insertionIndex += 1
                }
            }
            self.children[insertionIndex].insertNonFull(item)
        }
    }
    
    func remove(_ item: Element) {
        let removeIndex = self.findKey(item)
        if removeIndex < self.keys.count && self.keys[removeIndex] == item {
            // The key to remove is present in this node
            if self.leaf {
                self.removeFromLeaf(keyIndex: removeIndex)
            } else {
                self.removeFromNonLeaf(childIndex: removeIndex)
            }
        } else {
            if self.leaf {
                print("The item can't be removed because it doesn't exist in the tree")
                return
            }
            let lastNode = (removeIndex == self.keys.count) // Is in the last node?
            // If the child has than 'degree' keys, then fill that child
            if self.children[removeIndex].keys.count < self.degree {
                self.fill(removeIndex)
            }
            if lastNode && removeIndex > self.keys.count {
                // Child has been merged with the previous child
                self.children[removeIndex - 1].remove(item)
            } else {
                // Remove item from the expected child
                self.children[removeIndex].remove(item)
            }
        }
    }
    
    func splitChild(_ i: Int, oldNode: BTreeNode) {
        let newNode = BTreeNode(degree: oldNode.degree, leaf: oldNode.leaf)
        for j in 0..<(self.degree - 1) {
            newNode.keys.append(oldNode.keys[j + self.degree])
        }
        oldNode.keys.removeLast(self.degree - 1)
        if !oldNode.leaf {
            for j in 0..<degree {
                newNode.children.append(oldNode.children[j + self.degree])
            }
            oldNode.children.removeLast(self.degree)
        }
        let newKey = oldNode.keys[degree - 1]
        oldNode.keys.removeLast()
        self.keys.insert(newKey, at: i)
        self.children.insert(newNode, at: (i + 1))
    }
}

// MARK: Delete utilities for BTreeNode

private extension BTreeNode {
    
    func findKey(_ k: Element) -> Int{
        for i in 0..<self.keys.count {
            if self.keys[i] >= k {
                return i
            }
        }
        return self.keys.count
    }
    
    func removeFromLeaf(keyIndex removeIndex: Int) {
        self.keys.remove(at: removeIndex)
    }
    
    func removeFromNonLeaf(childIndex removeIndex: Int) {
        if self.children[removeIndex].keys.count >= self.degree {
            // If the child that precedes the item to remove has at least
            // 'degree' keys, find the predecesor of the item (key) and
            // replace the item to remove by this, then delete the original
            // predecesor item.
            let predecesorItem = self.getPredecesor(keyIndex: removeIndex)
            self.keys[removeIndex] = predecesorItem
            self.children[removeIndex].remove(predecesorItem)
        } else if (self.children[removeIndex + 1].keys.count >= self.degree) {
            // If the child that success the item to remove has at least
            // 'degree' keys, find the successor of the item (key) and
            // replace the item to remove by this, then delete the original
            // successor item.
            let successorItem = self.getSuccessor(keyIndex: removeIndex)
            self.keys[removeIndex] = successorItem
            self.children[removeIndex + 1].remove(successorItem)
        } else {
            let item = self.keys[removeIndex]
            self.mergeWithNextChild(childIndex: removeIndex)
            self.children[removeIndex].remove(item)
        }
    }
    
    func getPredecesor(keyIndex: Int) -> Element {
        //TODO: Implementation
        return 1 as! Element
    }
    
    func getSuccessor(keyIndex: Int) -> Element {
        //TODO: Implementation
        return 1 as! Element
    }
    
    func fill(_ index: Int) {
        //TODO: Implementation
    }
    
    func borrowFromNextChild(childIndex: Int) {
        //TODO: Implementation
    }
    
    func borrowFromPreviousChild(childIndex: Int) {
        //TODO: Implementation
    }
    
    func mergeWithNextChild(childIndex: Int) {
        //TODO: Implementation
    }
}

// MARK: BTree class

class BTree<Element> where Element: Comparable {
    var root: BTreeNode<Element>?
    var degree: Int // minimum degree
    
    init(degree: Int) {
        self.root = nil
        self.degree = degree
    }
    
    func traverse() {
        root?.traverse()
    }
    
    func search(_ searchItem: Element) -> BTreeNode<Element>? {
        return self.root?.search(searchItem)
    }
    
    func insert(_ item: Element) {
        if let root = self.root {
            let maxSize = 2 * self.degree - 1
            if root.keys.count < maxSize {
                // There is space for the insertion
                root.insertNonFull(item)
            } else {
                // No space, create new root
                let newRoot = BTreeNode<Element>(degree: self.degree, leaf: false)
                newRoot.children.append(root)
                newRoot.splitChild(0, oldNode: root)
                var i = 0
                if newRoot.keys[0] < item {
                    i += 1
                }
                newRoot.children[i].insertNonFull(item)
                self.root = newRoot
            }
        } else {
            // There isn't any node, create the root and assign the item.
            let root = BTreeNode<Element>(degree: self.degree, leaf: true)
            root.keys.append(item)
            self.root = root
        }
    }
    
    func remove(_ item: Element) {
        if let root = self.root {
            root.remove(item)
            if root.keys.count == 0 {
                if root.leaf {
                    self.root = nil
                } else {
                    self.root = root.children.first!
                }
            }
        } else {
            print("The item was not removed because the tree is empty")
        }
    }
}

var tree = BTree<Int>(degree: 3)
tree.insert(10)
tree.insert(20)
tree.insert(5)
tree.insert(6)
tree.insert(12)
tree.insert(30)
tree.insert(7)
tree.insert(17)
tree.traverse()
var k = 6
if tree.search(k) != nil {
    print("Item \(k) found!!")
} else {
    print("Item \(k) not found")
}
k = 15
if tree.search(k) != nil {
    print("Item \(k) found!!")
} else {
    print("Item \(k) not found")
}

