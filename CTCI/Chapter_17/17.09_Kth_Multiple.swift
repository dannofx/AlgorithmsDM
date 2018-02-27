// Kth Multiple

import Foundation

class Node<Element> {
    let value: Element
    var next: Node?
    
    init(value: Element) {
        self.value = value
    }
}

struct Queue<Element> {
    
    var head: Node<Element>?
    var tail: Node<Element>?
    
    init() {
        
    }
    
    mutating func enqueue(_ value: Element) {
        let node = Node(value: value)
        if self.head == nil {
            self.head = node
        }
        if let tail = self.tail {
            tail.next = node
        }
        self.tail = node
    }
    
    mutating func dequeue() -> Element? {
        guard let first = self.head else {
            return nil
        }
        self.head = first.next
        if first === self.tail {
            self.tail = nil
        }
        return first.value
    }
    
    func peek() -> Element? {
        return self.head?.value
    }
    
    var isEmpty: Bool {
        return self.head == nil
    }
}


func findNumber(at k: Int) -> Int {
    var queue3 = Queue<Int>()
    var queue5 = Queue<Int>()
    var queue7 = Queue<Int>()
    var val = 0
    queue3.enqueue(1)
    for _ in 0..<k {
        let val3 = queue3.peek() ?? Int.max
        let val5 = queue5.peek() ?? Int.max
        let val7 = queue7.peek() ?? Int.max
        val = min(val3, val5, val7)
        if val == val3 {
            _ = queue3.dequeue()
            queue3.enqueue(val * 3)
            queue5.enqueue(val * 5)
            queue7.enqueue(val * 7)
        } else if val == val5 {
            _ = queue5.dequeue()
            queue5.enqueue(val * 5)
            queue7.enqueue(val * 7)
        } else {
            _ = queue7.dequeue()
            queue7.enqueue(val * 7)
        }
    }
    return val
}

let k = 5
let result = findNumber(at: k)
print("The number in the position number \(k) for multiples of 3, 5 and 7 is: \(result)")
