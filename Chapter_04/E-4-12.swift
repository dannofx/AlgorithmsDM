// Chapter 4, Exercise 4.12
//Devise an algorithm for finding the k smallest elements of an unsorted set of n integers in O(n + k log n)

// Heap implementation
struct Heap<T: Comparable> {
    private var queue = [T]()
    
    mutating func makeHeap(fromArray array: [T]) {
        for newElement in array {
            self.insert(element: newElement)
        }
    }
    
    mutating func heapify(array: [T]) {
        self.queue = array
        for i in stride(from: self.queue.count / 2, through: 0, by: -1) {
            self.bubbleDown(index: i)
        }
    }
    
    mutating func convertToSortedArray() -> [T] {
        var array = [T]()
        for _ in 0..<self.queue.count {
            if let element = self.extractMin() {
                array.append(element)
            }
        }
        return array
    }
    
    mutating func bubbleDown(index: Int) {
        var minIndex = index
        for child in self.childrenIndexes(forIndex: index) {
            if self.queue[child] < self.queue[minIndex] {
                minIndex = child
            }
        }
        
        if minIndex != index {
            self.swapElements(aIndex: minIndex, bIndex: index)
            self.bubbleDown(index: minIndex)
        }
    }
    
    mutating func bubbleUp(index: Int) {
        
        guard let parent = self.parentIndex(forIndex: index) else {
            return
        }
        
        if queue[parent] > queue[index] {
            self.swapElements(aIndex: parent, bIndex: index)
            self.bubbleUp(index: parent)
        }
        
        
    }
    
    func childrenIndexes(forIndex index: Int) -> [Int] {
        var children = [Int]()
        if let young = self.youngChildIndex(forIndex: index) {
            children.append(young)
        }
        if let old = self.olderChildIndex(forIndex: index) {
            children.append(old)
        }
        return children
    }
    
    func olderChildIndex(forIndex index: Int) -> Int? {
        return self.youngChildIndex(forIndex: index, young: false)
    }
    
    func youngChildIndex(forIndex index: Int, young: Bool = true) -> Int?{
        let addition = young ? 0 : 1
        let childIndex = (index + 1) * 2 + addition - 1
        if childIndex < queue.count {
            return childIndex
        } else {
            return nil
        }
    }
    
    func parentIndex(forIndex index: Int) -> Int? {
        if index == 0 {
            return nil
        } else {
            return index / 2
        }
    }
    
    mutating func swapElements(aIndex a: Int, bIndex b: Int) {
        if a < 0 || b < 0 || a >= queue.count || b >= queue.count {
            return
        }
        let aux = self.queue[a]
        self.queue[a] = self.queue[b]
        self.queue[b] = aux
    }
    
    mutating func insert(element: T) {
        queue.append(element)
        let index = queue.count - 1
        self.bubbleUp(index: index)
    }
    
    func getMinimum() -> T? {
        return self.queue.first
    }
    
    func getMaximum() -> T? {
        guard let index = self.getMaximumIndex() else {
            return nil
        }
        return self.queue[index]
    }
    func getMaximumIndex() -> Int? {
        if self.queue.count == 0 {
            return nil
        }
        let first = self.queue.count / 2
        let limit = self.queue.count
        var maxIndex = 0
        var maxValue = self.queue[maxIndex]
        for i in first..<limit {
            if maxValue < self.queue[i] {
                maxValue = self.queue[i]
                maxIndex = i
            }
        }
        return maxIndex
    }
    
    mutating func extractMin() -> T? {
        if queue.count > 0 {
            let min = self.queue[0]
            if self.queue.count == 1 {
                self.queue.removeFirst()
                return min
            }
            self.remove(at: 0)
            if self.queue.count > 1 {
                self.bubbleDown(index: 0)
            }
            return min
        }
        return nil
    }
    
    mutating func extractMax() -> T? {
        guard let maxIndex = self.getMaximumIndex() else {
            return nil
        }
        let maxValue = self.queue[maxIndex]
        let lastIndex = self.queue.count - 1
        self.queue[maxIndex] = self.queue[lastIndex]
        self.remove(at: lastIndex)
        self.bubbleDown(index: maxIndex)
        return maxValue
    }
    
    mutating func remove(at index: Int) {
        let newElement = self.queue.removeLast()
        if index < self.queue.count {
            self.queue[index] = newElement
            self.bubbleDown(index: index)
        }
    }
}

// Problem

var input = [5,4,6,3,7,2,8,1,9,10]
var k = 5
var heap = Heap<Int>()
heap.heapify(array: input)
for i in 0..<k {
    let min = heap.extractMin() ?? -1
    print("Minimum at index \(i): \(min)")
}





