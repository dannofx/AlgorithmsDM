// B-Tree

// MARK: BTree node class

class BTreeNode<Element> where Element: Comparable {
    var keys: [Element?]
    var children: [BTreeNode?]
    var n: Int // number of elements
    var t: Int // degree
    var leaf: Bool
    
    init(t: Int, leaf: Bool) {
        self.t = t
        self.leaf = leaf
        let size = 2 * self.t
        self.keys = [Element?].init(repeating: nil, count: size - 1)
        self.children = [BTreeNode?].init(repeating: nil, count: size)
        self.n = 0
    }
    
    func traverse() {
        for (i, key) in keys.enumerated() {
            if let key = key {
                print("\(key) ")
            }
            if !self.leaf {
                self.children[i]?.traverse()
            }
        }
        if !self.leaf {
            self.children[n]?.traverse()
        }
    }
    
    func search(_ searchItem: Element) -> BTreeNode?{
        var i = 0
        while i < self.n && searchItem > self.keys[i]! {
            i += 1
        }
        if self.keys[i]! == searchItem {
            return self
        }
        if self.leaf {
            return nil
        }
        return children[i]?.search(searchItem)
    }
    
    func insertNonFull(_ item: Element) {
        var i = self.n - 1
        if self.leaf {
            // The node is leaf,
            // just look for the correct space for the insertion
            while (i >= 0 && self.keys[i]! > item) {
                self.keys[i + 1] = self.keys[i]
                i -= 1
            }
            self.keys[i + 1] = item
            n += 1
        } else {
            // This node is no leaf
            // Look for the correct space
            while i >= 0 && self.keys[i]! > item {
                i -= 1
            }
            
            // Split the child if necessary
            if let child = self.children[i + 1], child.n == (2 * t - 1) {
                self.splitChild(i + 1, oldNode: child)
                if self.keys[i + 1]! < item {
                    i += 1
                }
            }
            self.children[i + 1]?.insertNonFull(item)
        }
    }
    
    func splitChild(_ i: Int, oldNode: BTreeNode) {
        let newNode = BTreeNode.init(t: oldNode.t, leaf: oldNode.leaf)
        newNode.n = self.t - 1
        for j in 0..<(self.t - 1) {
            newNode.keys[j] = oldNode.keys[j]
        }
        if !oldNode.leaf {
            for j in 0..<t {
                newNode.children[j] = oldNode.children[j]
            }
        }
        oldNode.n = t - 1
        for j in stride(from: self.n, through: (i + 1), by: -1) {
            self.children[j + 1] = self.children[j]
        }
        self.children[i + 1] = newNode
        for j in stride(from: (n - 1), through: i, by: -1) {
            self.keys[j + 1] = self.keys[j]
        }
        self.keys[i] = oldNode.keys[self.t - 1]
        n = n + 1
    }
}

// MARK: BTree class

class BTree<Element> where Element: Comparable {
    var root: BTreeNode<Element>?
    var t: Int // minimum degree
    
    init(t: Int) {
        self.root = nil
        self.t = t
    }
    
    func traverse() {
        root?.traverse()
    }
    
    func search(_ searchItem: Element) -> BTreeNode<Element>? {
        return self.root?.search(searchItem)
    }
    
    func insert(_ item: Element) {
        if let root = self.root {
            let maxSize = 2 * t - 1
            if root.n < maxSize {
                // There is space for the insertion
                root.insertNonFull(item)
            } else {
                // No space, create new root
                let newRoot = BTreeNode<Element>(t: self.t, leaf: false)
                newRoot.children[0] = root
                newRoot.splitChild(0, oldNode: root)
                var i = 0
                if newRoot.keys[0]! < item {
                    i += 1
                }
                newRoot.children[i]?.insertNonFull(item)
                self.root = newRoot
            }
        } else {
            // There isn't any node, create the root and assign the item.
            self.root = BTreeNode(t: self.t, leaf: true)
            self.root?.keys[0] = item
            self.root?.n = 1
        }
    }
}

var tree = BTree<Int>(t: 3)
tree.insert(10)
tree.insert(20)
tree.insert(5)
tree.insert(6)
tree.insert(12)
tree.insert(30)
tree.insert(7)
tree.insert(17)
tree.traverse()
print("==")
//var k = 6
//if tree.search(k) != nil {
//    print("Item \(k) found!!")
//} else {
//    print("Item \(k) not found")
//}
//k = 15
//if tree.search(k) != nil {
//    print("Item \(k) found!!")
//} else {
//    print("Item \(k) not found")
//}

