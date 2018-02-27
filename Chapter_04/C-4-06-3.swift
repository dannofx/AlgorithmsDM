// Chapter 4, Challenge 4.6.3
//Vito's Family

var totalTime = 0
var originArray = [1,2,5,10]
//var destiny = [Int]()

var origin = Heap<Int>()
origin.heapify(array: originArray)
var destiny = Heap<Int>()

while (origin.count > 0) {
    if let crossBackMan = destiny.extractMin() {
        print("Crossing back: \(crossBackMan)")
        origin.insert(element: crossBackMan)
        totalTime += crossBackMan
    }
    var crossGroup = [Int]()
    for _ in 0..<2 {
        if origin.count > 0 {
            if let pos = destiny.getMinimum(), pos < origin.getMaximum()! {
                crossGroup.append(origin.extractMax()!)
            } else {
                crossGroup.append(origin.extractMin()!)
            }
        }
    }
    print("Crossing: \(crossGroup)")
    totalTime += crossGroup.max()!
    for element in crossGroup {
        destiny.insert(element: element)
    }
}

print("Total time: \(totalTime)")
