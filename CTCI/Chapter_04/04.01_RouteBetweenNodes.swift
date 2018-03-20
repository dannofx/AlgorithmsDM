//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Route between nodes

import Foundation

// MARK: Queue
class Queue {
  
  class QueueNode {
    let value: Node
    var next: QueueNode?
    
    init(_ value: Node) {
      self.value = value
    }
    
  }
  
  private var head: QueueNode?
  private var tail: QueueNode?
  private(set) var count: Int
  
  init() {
    self.count = 0
  }
  
  func queue(_ node: Node) {
    self.count += 1
    let newQNode = QueueNode(node)
    if self.head == nil {
      self.head = newQNode
    }
    if self.tail == nil{
      self.tail = newQNode
    } else {
      self.tail?.next = newQNode
      self.tail = newQNode
    }
  }
  
  func dequeue() -> Node? {
    guard let first = self.head else { return nil }
    self.head = first.next
    if first === self.tail {
      self.tail = nil
    }
    return first.value
  }
  
  func peek() -> Node? {
    return self.head?.value
  }
  
}

// MARK: Node
class Node {
  let value: String
  var edges: [Node]
  
  init(value: String) {
    self.value = value
    self.edges = [Node]()
  }
  
  func existsPath(_ other: Node) -> Bool {
    let queue = Queue()
    queue.queue(self)
    while let current = queue.dequeue() {
      if current === other {
        return true
      }
      for neighbor in current.edges {
        queue.queue(neighbor)
      }
    }
    return false
  }
}


// MARK: Test
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
print("Is there a path between \(root.value) and \(nodeF.value): \(root.existsPath(nodeF))")
