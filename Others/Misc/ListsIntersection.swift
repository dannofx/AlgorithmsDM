import Foundation

class Node<Element> where Element: Comparable {
  var next: Node?
  let value: Element
  
  init(value: Element) {
    self.value =  value
  }  
}

class List<Element> where Element: Comparable {
  private(set) var head: Node<Element>?
  private(set) var tail: Node<Element>?
  
  func appendValue(_ value: Element) -> Node<Element> {
    let newNode = Node(value: value)
    // Set head
    if self.head == nil {
      self.head = newNode
    }
    // Update/Set tail
    if self.tail != nil {
      self.tail?.next = newNode
    }
    self.tail = newNode
    return newNode
  }
  
  func appendNode(_ node: Node<Element>) {
    self.tail?.next = node
    var lastNode = node
    while let currentNode = lastNode.next {
      lastNode = currentNode
    }
    self.tail = lastNode
  }
  
  func length() -> Int {
    var count = 0
    var currentNode = self.head
    if currentNode != nil {
      count += 1
    }
    while currentNode?.next != nil {
      currentNode = currentNode?.next
      count += 1
    }
    return count
  }
  
  func head(offsetBy offset: Int) -> Node<Element>? {
    var i = 0
    var node = self.head
    while i < offset {
      node = node?.next
      i += 1
    }
    return node
  }
  
  func findIntersection(_ other: List<Element>) -> Node<Element>? {
    guard let tail1 = self.tail else { return nil }
    guard let tail2 = other.tail else { return nil }
    if tail1.value != tail2.value {
      // No intersection
      return nil
    }
    // Find intersection
    let len1 = self.length()
    let len2 = other.length()
    let offset1 = (len1 > len2 ? len1 - len2 : 0)
    let offset2 = (len2 > len1 ? len2 - len1 : 0)
    guard var node1 = self.head(offsetBy: offset1) else { return nil }
    guard var node2 = other.head(offsetBy: offset2) else { return nil }
    while node1 !== node2 {
      guard let next1 = node1.next else { return nil }
      guard let next2 = node2.next else { return nil }
      node1 = next1
      node2 = next2
    }
    return node1
  }
  
}


var list1 = List<Int>()
_ = list1.appendValue(1)
_ = list1.appendValue(2)
_ = list1.appendValue(1)
_ = list1.appendValue(1)
_ = list1.appendValue(5)
let intersection = list1.appendValue(100)
_ = list1.appendValue(1)
_ = list1.appendValue(2)
_ = list1.appendValue(1)
var list2 = List<Int>()
_ = list2.appendValue(23)
_ = list2.appendValue(24)
_ = list2.appendValue(25)
list2.appendNode(intersection)
if let foundIntersection = list1.findIntersection(list2) {
  print("Intersection at \(foundIntersection.value)")
} else {
  print("No intersection found")
}