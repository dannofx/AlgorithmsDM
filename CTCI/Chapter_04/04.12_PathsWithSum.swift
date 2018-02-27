// Paths with sum

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

protocol Summable: Hashable {
    static func +(lhs: Self, rhs: Self) -> Self
    static func -(lhs: Self, rhs: Self) -> Self}

extension Int: Summable {}

class TreeNode<Element> where Element: Comparable, Element: Summable {
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
    
    private func countPathsWithSum(targetSum: Element, sums: inout [Element: Int], previousSum: Element) -> Int{
        let currentSum = previousSum + self.value
        let neededSum  = currentSum - targetSum // If the sum exceeded the target, this value is the exceeded amount
        var totalPaths = sums[neededSum] ?? 0 // If there are previous sums with the exceeded value, every sum could
                                              // be substracted and could be a way to hit the target in this iteration
        if currentSum == targetSum {
            totalPaths += 1
        }
        let currentSumCount = sums[currentSum] ?? 0 + 1
        sums[currentSum] = currentSumCount
        totalPaths += self.left?.countPathsWithSum(targetSum: targetSum, sums: &sums, previousSum: currentSum) ?? 0
        totalPaths += self.right?.countPathsWithSum(targetSum: targetSum, sums: &sums, previousSum: currentSum) ?? 0
        if currentSumCount == 1 {
            sums.removeValue(forKey: currentSum)
        } else {
            sums[currentSum] = currentSumCount - 1
        }
        return totalPaths
    }
    
    func countPathsWithSum(_ sum: Element) -> Int{
        var sumsDict = [Element: Int]()
        return self.countPathsWithSum(targetSum: sum, sums: &sumsDict, previousSum: 0 as! Element)
    }
}

let elements = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
if let tree = TreeNode<Int>.createSearchTree(elements: elements) {
    tree.print()
    let sum = 13
    print("Total paths that sum \(sum): \(tree.countPathsWithSum(sum))")
} else {
    print("No tree :(")
}
