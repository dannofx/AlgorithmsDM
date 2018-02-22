// Shortest Supersequence

import Foundation

// MARK: - Heap

struct Heap<T: Comparable> {
    private var items: [T]
    
    init() {
        self.items = [T]()
    }
    
    mutating func insert(_ element: T) {
        items.append(element)
        let index = items.count - 1
        self.bubbleUp(index: index)
    }
    
    func peekMinimum() -> T? {
        return self.items.first
    }
    
    mutating func removeMinimum() -> T? {
        guard let firstValue = self.items.first else {
            return nil
        }
        let lastValue = self.items.last!
        self.items[0] = lastValue
        self.items.removeLast()
        self.bubbleDown(index: 0)
        return firstValue
    }
}

private extension Heap {
    
    mutating func  bubbleUp(index: Int) {
        if index <= 0 || index >= self.items.count {
            return
        }
        let parent = index / 2
        if items[parent] > items[index] {
            self.swapElements(aIndex: parent, bIndex: index)
            self.bubbleUp(index: parent)
        }
    }
    
    mutating func  bubbleDown(index: Int) {
        if index < 0 || index >= self.items.count {
            return
        }
        var minIndex = index
        for child in self.childrenIndexes(forIndex: index) {
            if self.items[child] < self.items[minIndex] {
                minIndex = child
            }
        }
        if minIndex != index {
            self.swapElements(aIndex: minIndex, bIndex: index)
            self.bubbleDown(index: minIndex)
        }
    }
    
    func childrenIndexes(forIndex index: Int) -> [Int] {
        let rightIndex = (index + 1) * 2
        let leftIndex = rightIndex - 1
        var indexes = [Int]()
        if rightIndex < self.items.count {
            indexes.append(leftIndex)
            indexes.append(rightIndex)
        } else if leftIndex < self.items.count {
            indexes.append(leftIndex)
        }
        return indexes
    }
    
    mutating func swapElements(aIndex a: Int, bIndex b: Int) {
        if a < 0 || b < 0 || a >= items.count || b >= items.count {
            return
        }
        let aux = self.items[a]
        self.items[a] = self.items[b]
        self.items[b] = aux
    }
}

// MARK: - Queue

class QueueNode<T> {
    let value: T
    var next: QueueNode?
    
    init(value: T) {
        self.value = value
    }
}

struct Queue<T> {
    var head: QueueNode<T>?
    var tail: QueueNode<T>?
    
    init() {
        
    }
    
    mutating func enqueue(_ value: T) {
        let node = QueueNode(value: value)
        if self.head == nil {
            self.head = node
        }
        if let tail = self.tail {
            tail.next = node
        }
        self.tail = node
    }
    
    mutating func dequeue() -> T? {
        guard let first = self.head else {
            return nil
        }
        self.head = first.next
        if first === self.tail {
            self.tail = nil
        }
        return first.value
    }
    
    func peek() -> T? {
        return self.head?.value
    }
    
    var isEmpty: Bool {
        return self.head == nil
    }
}

// MARK: - Exercise logic

typealias SequenceRange = (start: Int, end: Int)

struct QueueInt: Comparable {
    let value: Int
    let queueIndex: Int
    
    init(value: Int, queueIndex: Int) {
        self.value = value
        self.queueIndex = queueIndex
    }
    
    static func ==(lhs: QueueInt, rhs: QueueInt) -> Bool {
        return lhs.value == rhs.value
    }
    
    static func <(lhs: QueueInt, rhs: QueueInt) -> Bool {
        return lhs.value < rhs.value
    }
    
}

func getLocations(for elements: [Int], in array: [Int]) -> [Queue<Int>] {
    var locations = [Int: Queue<Int>]()
    for element in elements {
        locations[element] = Queue<Int>()
    }
    for (i, value) in array.enumerated() {
        if locations[value] != nil {
            locations[value]!.enqueue(i)
        }
    }
    return [Queue<Int>](locations.values)
}

func findShortestClosure(lists: inout [Queue<Int>]) -> SequenceRange? {
    var minHeap = Heap<QueueInt>()
    var maxIndex = Int.min
    for i in 0..<lists.count {
        guard let value = lists[i].dequeue() else {
            return nil
        }
        let node = QueueInt(value: value, queueIndex: i)
        minHeap.insert(node)
        maxIndex = max(maxIndex, value)
    }
    var minIndex = minHeap.peekMinimum()!.value
    var bestMinIndex = minIndex
    var bestMaxIndex = maxIndex
    while true {
        let discardedNode = minHeap.removeMinimum()!
        minIndex = discardedNode.value
        if (maxIndex - minIndex) < (bestMaxIndex - bestMinIndex) {
            bestMaxIndex = maxIndex
            bestMinIndex = minIndex
        }
        guard let newIndex = lists[discardedNode.queueIndex].dequeue() else {
            break
        }
        let newNode = QueueInt(value: newIndex, queueIndex: discardedNode.queueIndex)
        minHeap.insert(newNode)
        maxIndex = max(maxIndex, newIndex)
    }
    return (bestMinIndex, bestMaxIndex)
}

func findShortesSuperSequence(array: [Int], elements: [Int]) -> SequenceRange? {
    var locations = getLocations(for: elements, in: array)
    return findShortestClosure(lists: &locations)
}

// MARK: - Test

let elements = [1, 5, 9]
let array = [7, 5, 9, 0, 2, 1, 3, 5, 7, 9, 1, 1, 5, 8, 8, 9, 7]
print("Elements: \(elements)")
print("Array: \(array)")
if let range = findShortesSuperSequence(array: array, elements: elements) {
    print("Super sequence: (start: \(range.start), end: \(range.end))")
} else {
    print("Error: No super sequence found")
}

