import Foundation

// MARK: Heap

struct Heap<T: Comparable> {
  private(set) var items: [T]
  let isMax: Bool
  
  init(isMax: Bool) {
    self.items = [T]()
    self.isMax = isMax
  }
  
  init(isMax: Bool, array: [T]) {
    self.isMax = isMax
    self.items = array
    for i in stride(from: self.count / 2, through: 0, by: -1) {
        self.bubbleDown(i)
    }
  }
  
  var count: Int {
    return self.items.count
  }
  
  mutating func insert(_ item: T) {
    items.append(item)
    let index = self.count - 1
    self.bubbleUp(index)
  }
  
  mutating func removeTop() -> T? {
    guard let firstValue = self.items.first else { return nil }
    guard let lastValue = self.items.last else { return nil }
    self.items[0] = lastValue
    self.items.removeLast()
    self.bubbleDown(0)
    return firstValue
  }
  
  func peekTop() -> T? {
    return self.items.first
  }
}

private extension Heap {
  
  mutating func bubbleUp(_ index: Int) {
    if index <= 0 {
      return 
    }
    let parentIndex = index / 2
    let childIsLess = self.items[parentIndex] > self.items[index]
    if childIsLess != self.isMax {
      self.items.swapAt(index, parentIndex)
      self.bubbleUp(parentIndex)
    }
  }
  
  mutating func bubbleDown(_ index: Int) {
    guard let nextIndex = getNextChildIndex(index) else { return }
    let nextIsLess = self.items[nextIndex] < self.items[index]
    if nextIsLess != self.isMax {
      self.items.swapAt(nextIndex, index)
      self.bubbleDown(nextIndex)
    }
  }
  
  func getNextChildIndex(_ index: Int) -> Int?{
    let rightIndex = (index + 1) * 2
    let leftIndex = rightIndex - 1
    if leftIndex >= self.count {
      return nil
    } else {
      if rightIndex >= self.count {
        return leftIndex
      } else {
        let leftIsLess = self.items[leftIndex] < self.items[rightIndex] 
        if leftIsLess != self.isMax{
          return leftIndex
        } else {
          return rightIndex
        }
      }
    }
  }
}

var numbers = [4,5,3,6,22,2,2,2,7,1,8,9,0]
var heap = Heap<Int>(isMax: false, array: numbers)
print(heap.items)
heap.insert(4)
heap.insert(3)
heap.insert(0)
heap.insert(4)
heap.insert(10)
heap.insert(40)
print(heap.items)
_ = heap.removeTop()
print(heap.items)
_ = heap.removeTop()
print(heap.items)
_ = heap.removeTop()
print(heap.items)
_ = heap.removeTop()
print(heap.items)
_ = heap.removeTop()
print(heap.items)
_ = heap.removeTop()
print(heap.items)