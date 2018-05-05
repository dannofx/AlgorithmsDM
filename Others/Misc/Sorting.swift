import Foundation

// MARK: Mergesort

extension Array where Element: Comparable {
  
  private mutating func merge(start: Int, end: Int, middle: Int) {
    var aux = Array(self[start...middle])
    var current = start
    var index1 = 0
    var index2 = middle + 1
    while index1 < aux.count && index2 <= end {
      if aux[index1] < self[index2] {
        self[current] = aux[index1]
        index1 += 1
      } else {
        self[current] = self[index2]
        index2 += 1
      }
      current += 1
    }
    while index1 < aux.count {
      self[current] = aux[index1]
      index1 += 1
      current += 1
    }
  }
  
  private mutating func mergeSort(start: Int, end: Int) {
    if start >= end {
      return
    }
    let middle = (end - start) / 2 + start
    mergeSort(start: start, end: middle)
    mergeSort(start: middle + 1, end: end)
    merge(start: start, end: end, middle: middle)
  }
  
  mutating func mergeSort() {
    mergeSort(start: 0, end: self.count - 1)
  }
  
}

// MARK: QuickSort

extension Array where Element: Comparable {
    
  private mutating func partition(start: Int, end: Int) -> Int {
    let pivot = self[end]
    var current = start
    for i in start..<end {
      if self[i] < pivot {
        self.swapAt(i, current)
        current += 1
      }
    }
    swapAt(current, end)
    return current
  }
  
  private mutating func quickSort(start: Int, end: Int) {
    if start >= end {
      return 
    }
    let pivotIndex = self.partition(start: start, end: end)
    self.quickSort(start: start, end: pivotIndex - 1)
    self.quickSort(start: pivotIndex + 1, end: end)
  }
  
  mutating func quickSort() {
    self.quickSort(start: 0, end: self.count - 1)
  }
  
}

var numbers = [4,5,3,6,22,2,2,2,7,1,8,9,0]
numbers.mergeSort()
print(numbers)

numbers = [4,5,3,6,22,2,2,2,7,1,8,9,0]
numbers.quickSort()
print(numbers)