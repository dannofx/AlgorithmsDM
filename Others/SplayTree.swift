// Splay tree

class SplayNode<Element> where Element: Comparable {
    let value: Element
    var right: SplayNode<Element>?
    var left: SplayNode<Element>?
    
    init(value: Element) {
        self.value = value
    }
    
    func printOrder() {
        print("Value: \(self.value)")
        self.left?.printOrder()
        self.right?.printOrder()
    }
    
    func rightRotate() -> SplayNode? {
        guard let leftNode = self.left else {
            return nil
        }
        self.left = leftNode.right
        leftNode.right = self
        return leftNode
    }
    
    func leftRotate() -> SplayNode? {
        guard let rightNode = self.right else {
            return nil
        }
        self.right = rightNode.left
        rightNode.left = self
        return rightNode
    }
    
    /// Looks for the node with an specified value, if it's found,
    /// returns the node with the value, being this node now the new
    /// parent of all the other nodes (root), if it doesn't find it
    /// returns the node more aproximate to the value and it will
    /// also be the root of all the nodes.
    ///
    /// - Parameter value: The value to search
    /// - Returns: A node to be returned with the value searched or at least with
    ///            the most proximate value
    func splay(value: Element) -> SplayNode {
        var root = self
        if root.value == value {
            return root
        }
        if root.value > value {
            // The value is in the left tree
            guard let leftChild = root.left else {
                return root
            }
            if leftChild.value > value {
                // The value should be to the left
                if let leftGrandChild = leftChild.left {
                   leftChild.left = leftGrandChild.splay(value: value)
                }
                root = root.rightRotate()!
            } else if leftChild.value < value {
                // The value should be to the right
                if let rightGrandChild = leftChild.right {
                    leftChild.right = rightGrandChild.splay(value: value)
                    root.left = leftChild.leftRotate()
                }
            }
            return root.left == nil ? root : root.rightRotate()!
            
        } else {
            // The value is in the right tree
            guard let rightChild = root.right else{
                return root
            }
            if rightChild.value < value {
                // The value should be to the right
                if let rightGrandChild = rightChild.right {
                    rightChild.right = rightGrandChild.splay(value: value)
                }
                root = root.leftRotate()!
            } else if rightChild.value < value {
                // The value should be to the left
                if let leftGrandChild = rightChild.left {
                    rightChild.left = leftGrandChild.splay(value: value)
                    root.right = rightChild.rightRotate()
                }
            }
            return root.right == nil ? root : root.leftRotate()!
        }
    }
    
    
    /// Inserts a new element as the root of the tree
    /// if the element already exists, just converts
    /// the existing node in the new root.
    ///
    /// - Parameter value: Value to insert.
    /// - Returns: The new root of the tree
    func insert(value: Element) -> SplayNode{
        let root = self.splay(value: value)
        if root.value == value {
            return root
        }
        let newNode = SplayNode(value: value)
        if root.value > value {
            newNode.right = root
            newNode.left = root.left
            root.left = nil
        } else {
            newNode.left = root
            newNode.right = root.right
            root.right = nil
        }
        return newNode
    }
    
    
    /// Deletes the node with the value from the tree
    /// and returns the new root of the tree after the
    /// rearangement. If it returns nil is because no
    /// node was left. If it doesn't find the requiered
    /// item anyways returns the new root after the rearangement.
    ///
    /// - Parameter value: The value for the node to delete.
    /// - Returns: The new root of the tree (if there is at
    ///            least one node left).
    func delete(value: Element) -> SplayNode? {
        let root = self.splay(value: value)
        if root.value != value {
            // Nothing to do, the value is not in the tree,
            // anyway, the tree was rearanged, so the new
            // root is returned
            print("Value \(value) not found in the tree.")
            return root
        }
        let newRoot: SplayNode?
        if let leftNode = root.left {
            // Left node exists.
            // Since the value was already found, and splay looking
            // for that value in the left tree will leave us with a new root
            // without right subtree, this because the value of the new root
            // will be the maximum of that tree and since it's the maximum this
            // can't have a right member, leaving this place to position the remaining
            // part of the tree
            newRoot = leftNode.splay(value: value)
            newRoot?.right = root.right
            root.left = nil
            root.right = nil
            
        } else {
            // left node doesn't exist
            newRoot = root.right
            root.right = nil
        }
        return newRoot
    }
    
}

// Splay test
//var root = Node(value: 100)
//root.left = Node(value: 50)
//root.right = Node(value: 200)
//root.left?.left = Node(value: 40)
//root.left?.left?.left = Node(value: 30)
//root.left?.left?.left?.left = Node(value: 20)
//let t = 20
//root = root.splay(value: t)
//if root.value == t {
//    print("Value found! Order of elements:")
//} else {
//    print("Value not found, but the tree order now is: ")
//}
//root.printOrder()

// Insertion test
//var root = Node(value: 100)
//root.left = Node(value: 50)
//root.right = Node(value: 200)
//root.left?.left = Node(value: 40)
//root.left?.left?.left = Node(value: 30)
//root.left?.left?.left?.left = Node(value: 20)
//root = root.insert(value: 25)
//print("The order after insertion is:")
//root.printOrder()

// Deletion test
var root = SplayNode(value: 6)
root.left = SplayNode(value: 1)
root.right = SplayNode(value: 9)
root.left?.right = SplayNode(value: 4)
root.left?.right?.left = SplayNode(value: 2)
root.right?.left = SplayNode(value: 7)
let t = 4
let newRoot = root.delete(value: t)
if let newRoot = newRoot {
    print("Preorder traversal of the modified Splay tree is:")
    newRoot.printOrder()
} else {
    print("No nodes left after deletion.")
}



