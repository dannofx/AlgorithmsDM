//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Route between nodes
import Foundation


class Node<Element: Comparable> {
    let value: Element
    var edges: [Node]
    var visited: Bool
    
    init(value: Element) {
        self.value = value
        self.edges = [Node]()
        self.visited = false
    }
    
    func existsPath(to target: Node) -> Bool {
        var queue = [Node]()
        queue.insert(self, at: 0)
        while let node = queue.popLast() {
            node.visited = true
            if node === target {
                return true
            }
            for child in node.edges {
                if !child.visited {
                    queue.insert(contentsOf: node.edges, at: 0)
                }
            }
        }
        return false
    }
}

var root = Node(value: "ROOT")
var nodeA = Node(value: "A")
var nodeB = Node(value: "B")
var nodeC = Node(value: "C")
var nodeD = Node(value: "D")
var nodeE = Node(value: "E")
var nodeF = Node(value: "F")
root.edges.append(nodeA)
root.edges.append(nodeB)
nodeA.edges.append(nodeC)
nodeC.edges.append(nodeD)
nodeC.edges.append(nodeE)
nodeE.edges.append(nodeF)
print("Is there a path between \(root.value) and \(nodeF.value): \(root.existsPath(to: nodeF))")


