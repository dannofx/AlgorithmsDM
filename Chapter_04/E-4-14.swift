// Chapter 4, Exercise 4.14

//Give an O(n log k)-time algorithm that merges k sorted lists with a total of n elements into one sorted list. (Hint: use a heap to speed up the elementary O(kn)- time algorithm)

struct ListElement<Element: Comparable>: Comparable {
    var element: Element
    var listIndex: Int
    
    static func < (lhs: ListElement, rhs: ListElement) -> Bool {
        return lhs.element < rhs.element
    }
    
    static func == (lhs: ListElement, rhs: ListElement) -> Bool {
        return lhs.element == rhs.element
    }
}

var sortedLists = [(elements: [Int], head: Int)]()
var a = [1,2,3,4,5]
var b = [6,8,10,12,13]
var c = [0,7,9,11,14]

sortedLists.append((a, 0))
sortedLists.append((b, 0))
sortedLists.append((c, 0))

var sortedHeap = Heap<ListElement<Int>>()
var finalList = [Int]()
for i in 0..<sortedLists.count {
    if let element = sortedLists[i].elements.first {
        let listElement = ListElement<Int>.init(element: element, listIndex: i)
        sortedHeap.insert(element: listElement)
        sortedLists[i].head += 1
    }
}

while let minimum = sortedHeap.extractMin() {
    finalList.append(minimum.element)
    var list = sortedLists[minimum.listIndex]
    if list.head < list.elements.count {
        let element = list.elements[list.head]
        let listElement = ListElement<Int>.init(element: element, listIndex: minimum.listIndex)
        sortedHeap.insert(element: listElement)
        sortedLists[minimum.listIndex].head += 1
    }
}

print("Result: \(finalList)")


