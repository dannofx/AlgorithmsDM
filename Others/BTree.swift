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

