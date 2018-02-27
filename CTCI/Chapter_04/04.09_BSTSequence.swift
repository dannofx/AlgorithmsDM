// BST Sequence

import Foundation

public extension Array where Element: Comparable {
    func uniqueSort() -> [Element] {
        var sorted = self.sorted()
        var result = [Element]()
        for i in 0..<sorted.count {
            if i > 0 && sorted[i - 1] == sorted[i] {
                continue
            }
            result.append(sorted[i])
        }
        return result
    }
}


class TreeNode<Element: Comparable> {
    let value: Element
    var left: TreeNode?
    var right: TreeNode?
    
    init(value: Element) {
        self.value = value
    }
    
    private func print(parentValue: Element) {
        Swift.print("(\(parentValue))\(self.value)")
        if let left = self.left {
            left.print(parentValue: self.value)
        }
        if let right = self.right {
            right.print(parentValue: self.value)
        }
    }
    func print() {
        Swift.print(self.value)
        if let left = self.left {
            left.print(parentValue: self.value)
        }
        if let right = self.right {
            right.print(parentValue: self.value)
        }
    }
    
    private class func createSearchTree(elements: [Element], start: Int, end: Int) -> TreeNode? {
        if start == end {
            return nil
        }
        let middle = start + ( end - start) / 2
        let node = TreeNode(value: elements[middle])
        node.left = createSearchTree(elements: elements, start: start, end: middle)
        node.right = createSearchTree(elements: elements, start: middle + 1, end: end)
        return node
    }
    
    class func createSearchTree(elements unsortedElements: [Element]) -> TreeNode? {
        let elements = unsortedElements.uniqueSort()
        return createSearchTree(elements: elements, start: 0, end: elements.count)
    }
    
    private func mixInOrder(_ arrays: [[Element]]) -> [[Element]] {
        var results = [[Element]]()
        for i in 0..<arrays.count {
            let array = arrays[i]
            let others = arrays[0..<i] + arrays[(i + 1)..<arrays.count]
            for limit in 0..<array.count {
                let fixedElements = array[0...limit]
                let remainingElements = array[(limit + 1)..<array.count]
                var input = [Array(remainingElements)]
                input.append(contentsOf:others)
                let subresults = mixInOrder(input)
                if subresults.count == 0 {
                    results.append(Array(fixedElements))
                    continue
                }
                for subresult in subresults {
                    if (limit + 1) < array.count && array[limit + 1] == subresult[0] {
                        continue
                    }
                    var result = [Element]()
                    result.append(contentsOf: fixedElements)
                    result.append(contentsOf: subresult)
                    results.append(result)
                }
            }
        }
        return results
    }
    
    func createBSTSequences() -> [[Element]] {
        var results = [[Element]]()
        if self.left == nil && self.right == nil {
            results.append([self.value])
            return results
        }
        let leftSequences = self.left?.createBSTSequences() ?? [[Element]()]
        let rightSequences = self.right?.createBSTSequences() ?? [[Element]()]
        for leftSequence in leftSequences {
            for rightSequence in rightSequences {
                let mixedSequences = self.mixInOrder([leftSequence, rightSequence])
                for mixedSequence in mixedSequences {
                    var result = [self.value]
                    result.append(contentsOf: mixedSequence)
                    results.append(result)
                }
            }
        }
        return results
    }
    
}

let elements = [1,2,3]
if let tree = TreeNode<Int>.createSearchTree(elements: elements) {
    tree.print()
    let sequences = tree.createBSTSequences()
    print("Sequences: ")
    for sequence in sequences {
        print(sequence)
    }
} else {
    print("No tree :(")
}









