// Chapter 3, Exercise 3-23

// Implement an algorithm to reverse a linked list. Now do it without recursion.

class ListNode {
  let value: Int
  var next: ListNode?
  init(value: Int) {
    self.value = value
  }
}

var headNode: ListNode?
var currentNode: ListNode?
// Populate
for i in 0...10 {
  if let previousNode = currentNode {
    let node = ListNode(value: i)
    previousNode.next = node 
    currentNode = node
  } else {
    headNode = ListNode(value: i)
    currentNode = headNode
  }
}

// Reverse
currentNode = headNode
var reversedHeadNode: ListNode?
while currentNode != nil {
  let nextNode = currentNode!.next
  currentNode!.next = reversedHeadNode
  reversedHeadNode = currentNode
  currentNode = nextNode
}

// Print reversed list
currentNode = reversedHeadNode
while currentNode != nil {
  print("Current node \(currentNode!.value)")
  currentNode = currentNode!.next
}
