import Foundation

class Node {
  let value: Int
  var next: Node?
  
  init(_ value: Int) {
    self.value = value
  }
}

func isPalindrome(node: Node) -> Bool {
  return compareNode(node: node, head: node).success
}

func compareNode(node: Node, head: Node) -> (compNode: Node?, success: Bool) {
  guard let next = node.next else {
    return (head.next, node.value == head.value)
  }
  let result = compareNode(node: next, head: head)
  let currentRes = result.compNode != nil ? (result.compNode!.value == node.value) : true
  return (result.compNode?.next, currentRes && result.success)
}

var node = Node(5)
var last = node
last.next = Node(4)
last = last.next!
last.next = Node(3)
last = last.next!
last.next = Node(1)
last = last.next!
last.next = Node(1)
last = last.next!
last.next = Node(3)
last = last.next!
last.next = Node(4)
last = last.next!
last.next = Node(5)
last = last.next!
last.next = Node(1)
last = last.next!

if isPalindrome(node: node) {
  print("Is palindrome")
} else {
  print("NO")
}