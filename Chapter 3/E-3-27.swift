// Chapter 3, Exercise 3-27

// Determine whether a linked list contains a loop as quickly as possible without using any extra storage. Also, identify the location of the loop.

class Node {
  let value: Int
  var next: Node?
  
  init(value: Int) {
    self.value = value
  }
}

// Populate (no loop)
var node1 = Node(value: 1)
var node2 = Node(value: 2)
node1.next = node2
var node3 = Node(value: 3)
node2.next = node3
var node4 = Node(value: 4)
node3.next = node4
//Loop
node4.next = node2

var slow: Node? = node1
var fast: Node? = node1.next
while fast != nil {
  if fast === slow {
    print("This is a loop")
    exit(0)
  }
  slow = slow?.next
  fast = fast?.next?.next
}

print("If not message before: This is not a loop")
