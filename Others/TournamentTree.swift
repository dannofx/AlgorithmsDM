// Tournament tree (find second minimum element)

// Given an array of integers, find the minimum (or maximum) element and
// the element just greater (or smaller) than that in less than 2n comparisons.
// The given array is not necessarily sorted. Extra space is allowed.

import Foundation

class Node {
    let element: Int
    var left, right: Node?
    init(_ element: Int) {
        self.element = element
    }
    
    var secondMinimum: Int? {
        // This method compares the element value that is not root with
        // the the second minimum element found in the branch
        // where the root element value belongs
        guard let left = left, let right = right else {
            return nil
        }
        let node: Node!
        let closeMinimum: Int!
        if element == left.element {
            node = left
            closeMinimum = right.element
        } else {
            node = right
            closeMinimum = left.element
        }
        if let innerMinimum = node.secondMinimum {

            return min(innerMinimum, closeMinimum)
        } else {
            return closeMinimum
        }
    }
}

func createTournamentTree(elements: [Int]) -> Node? {
    if elements.count < 2 {
        return nil
    }
    // This array will contain all the remaining independent leafs/nodes
    var nodes = [Node]()
    // Create a node for every element (leafs)
    for element in elements {
        let node = Node(element)
        nodes.append(node)
    }
    
    var size = nodes.count
    // We will be joining independent trees/leafs until
    // we just have a single tree.
    while size > 1 {
        for i in stride(from: 0, to: size, by: 2) {
            if ( i + 1 ) >= size {
                // There is no node/leaf left
                // to create other tree
                break
            }
            // Gets and removes the first two independent trees/nodes
            let first = nodes.removeFirst()
            let second = nodes.removeFirst()
            // Creates a new tree with the previous extracted elements
            let root = first.element < second.element ? Node(first.element) : Node(second.element)
            root.left = first
            root.right = second
            // Add this new tree to the list of remaining independent leafs/nodes
            nodes.append(root)
        }
        // Updates the size to be compared
        // (should be smaller)
        size = nodes.count
    }
    return nodes.first!
}


let elements = [99,33,45,21,67,23,15,54,78,10,12,11]
guard let tournamentTree = createTournamentTree(elements: elements) else {
    print("Error: \(elements.count) elements are not enough to create a tournament tree.")
    exit(1)
}
// Prints a representation of the tree
var representationNodes = [tournamentTree]
var level = 0
var representationSize = representationNodes.count
while representationSize != 0 {
    print("Level \(level + 1):")
    var stringNodes = ""
    for _ in 0..<representationSize {
        let node = representationNodes.removeFirst()
        stringNodes.append("\(node.element), ")
        if let left = node.left {
            representationNodes.append(left)
        }
        if let right = node.right {
            representationNodes.append(right)
        }
    }
    representationSize = representationNodes.count
    level += 1
    print(stringNodes)
}

// Find the minimum elements
let minimum = tournamentTree.element
let secondMinimum = tournamentTree.secondMinimum!
print("Minimum value: \(minimum)")
print("Second minimum value: \(secondMinimum)")

