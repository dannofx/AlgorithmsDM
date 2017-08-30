// Chapter 3, Exercise 3-20

// Write a function to find the middle node of a singly-linked list

class Node {
  let index: Int
  var nextNode: Node?
  init(index: Int) {
    self.index = index
  }
}

// Initialize singly linked list
var previousNode: Node?
var firstNode: Node?
for i in 1...100 {
  var node = Node(index: i)
  if firstNode == nil {
    firstNode = node
    previousNode = node
  } else {
    previousNode?.nextNode = node
    previousNode = node
  }
}

// Find middle node
var slow = firstNode
var fast = firstNode?.nextNode?.nextNode

while fast != nil {
  slow = slow?.nextNode
  fast = fast?.nextNode?.nextNode
}

print("Middle node: \(slow?.index ?? -1)")

