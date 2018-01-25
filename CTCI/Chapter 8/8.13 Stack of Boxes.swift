// Stack of Boxes

import Foundation

struct Box {
    let width: Int
    let height: Int
    let depth: Int
    
    func isSmaller(than box: Box) -> Bool {
        return box.height > self.height &&
                box.width > self.width &&
                box.depth > self.depth
    }
    
    static func createBox(_ width: Int, _ height: Int, _ depth: Int) -> Box {
        return Box(width: width, height: height, depth: depth)
    }
}

// MARK: - Solution 1

func calculateHighestStack(boxes: [Box], index: Int, cache: inout [Int]) -> Int {
    if index == boxes.count {
        return 0
    }
    if cache[index] > 0{
        return cache[index]
    }
    var maxHeight = 0
    let currentBox = boxes[index]
    for i in (index + 1)..<boxes.count {
        if boxes[i].isSmaller(than: currentBox) {
            let height = calculateHighestStack(boxes: boxes, index: i, cache: &cache)
            if height > maxHeight {
                maxHeight = height
            }
        }
    }
    cache[index] = maxHeight + currentBox.height
    return cache[index]
}

func calculateHighestStack(boxes: [Box]) -> Int {
    let sortedBoxes = boxes.sorted { $0.height > $1.height } // by height
    var cache = [Int](repeating: 0, count: sortedBoxes.count)
    return calculateHighestStack(boxes: sortedBoxes, index: 0, cache: &cache)
}

// MARK: Solution 2

func calculateCHighestStack(boxes: [Box], index: Int, baseBox: Box?, cache: inout [Int]) -> Int {
    if index == boxes.count {
        return 0
    }
    let nextIndex = index + 1
    var withHeight = 0
    if baseBox == nil || boxes[index].isSmaller(than: baseBox!) {
        if cache[index] == 0 {
            cache[index] = boxes[index].height
            cache[index] += calculateCHighestStack(boxes: boxes,
                                                   index: nextIndex,
                                                   baseBox: boxes[index],
                                                   cache: &cache)
        }
        withHeight = cache[index]
    }
    let withoutHeight = calculateCHighestStack(boxes: boxes,
                                               index: nextIndex,
                                               baseBox: baseBox,
                                               cache: &cache)
    return max(withHeight, withoutHeight)
}

func calculateCHighestStack(boxes: [Box]) -> Int {
    let sortedBoxes = boxes.sorted { $0.height > $1.height } // by height
    var cache = [Int](repeating: 0, count: sortedBoxes.count)
    return calculateCHighestStack(boxes: boxes, index: 0, baseBox: nil, cache: &cache)
}


var boxes = [Box]()
boxes.append(Box.createBox(30, 30, 30))
boxes.append(Box.createBox(20, 60, 20))
boxes.append(Box.createBox(10, 10, 10))
boxes.append(Box.createBox(5, 5, 5))
boxes.append(Box.createBox(1, 1, 1))

let maxHeight = calculateCHighestStack(boxes: boxes)
print("Max height of the stack: \(maxHeight)")


