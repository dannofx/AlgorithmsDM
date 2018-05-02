//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Route between nodes
import Foundation

// MARK: Queue

class Queue<T> {
  class QueueNode<T> {
    let value: T
    var next: QueueNode<T>?
    
    init(value: T) {
      self.value = value
    }
  }
  
  var head: QueueNode<T>?
  var tail: QueueNode<T>?
  private(set) var count: Int
  
  init() {
    self.count = 0
  }
  
  func queue(_ value: T) {
    self.count += 1
    let newNode = QueueNode(value: value)
    if self.head == nil {
      self.head = newNode
    }
    if self.tail == nil {
      self.tail = newNode
    } else {
      self.tail?.next = newNode
      self.tail =  newNode
    }
  }

  func dequeue() -> T? {
    guard let head = self.head else {
      return nil
    }
    self.count -= 1
    self.head = head.next
    if self.tail === head {
      self.tail = nil
    }
    return head.value
  }
  
  func peekNext() -> T? {
    return self.head?.value
  }

}

// MARK: Graph

class Node<T: Hashable> {
  let value: T
  var edges: [Node<T>]
  
  init(value: T) {
    self.value = value
    self.edges = [Node<T>]()
  }
  
  func existsPathBFS(_ other: Node<T>) -> Bool {
    var visited = Set<T>()
    let queue = Queue<Node<T>>()
    queue.queue(self)
    visited.insert(self.value)
    while let current = queue.dequeue() {
      if current.value == other.value {
        return true
      }
      for node in current.edges {
        if !visited.contains(node.value) {
          queue.queue(node)
          visited.insert(node.value)
        }
      }
    }
    return false
  }
//   Don't use DFS, BFS is better for this kind of problem.
//   I just leaved DFS to make a comparison of the implementation
//   func existsPathDFS(_ other: Node<T>, visited: inout Set<T>) -> Bool {
//     if visited.contains(self.value) {
//       return false
//     }
//     visited.insert(self.value)
//     if self.value == other.value {
//       return true
//     }
//     for node in self.edges {
//       if node.existsPathDFS(other, visited: &visited) {
//         return true
//       }
//     }
//     return false
//   }
  
//   func existsPathDFS(_ other: Node<T>) -> Bool {
//     var visited = Set<T>()
//     return self.existsPathDFS(other, visited: &visited)
//   }
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
//nodeE.edges.append(nodeF)
print("BFS Is there a path between \(root.value) and \(nodeF.value): \(root.existsPathBFS(nodeF))")

