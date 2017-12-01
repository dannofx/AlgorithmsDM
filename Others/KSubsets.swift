// K-Subsets

// Subset sum problem is to find subset of elements that are selected from a given set whose
// sum adds up to a given number K. We are considering the set contains non-negative values.
// It is assumed that the input set is unique (no duplicates are presented).

import Foundation

func getKSubsets(elements:[Int], k: Int, subset: inout [Int], index: Int, currentSum: Int, resultSubsets: inout [[Int]]) {
    // Check if the sum of the current subset is equal to k
    if currentSum == k {
        // A valid subset was found, save it
        resultSubsets.append(subset)
        // Discard the last element added and continue with the next one
        // to see if there are more subsets with the first part of the
        // found subset
        if index < elements.count {
            let removedElement = subset.removeLast()
            let newCurrentSum = currentSum - removedElement
            // Since the elements are sorted if the next element exceeds
            // k, any further element will exceed it too.
            if newCurrentSum + elements[index] <= k {
                getKSubsets(elements: elements,
                            k: k,
                            subset: &subset,
                            index: index,
                            currentSum: newCurrentSum,
                            resultSubsets: &resultSubsets)
            }
        }
    } else {

        // Return if the index is out of scope
        if index >= elements.count{
            return
        }
        
        // Loop the array to try to add each element as the next element
        // in the subset
        for i in index..<elements.count {
            let element = elements[i]
            let newCurrentSum = currentSum + element
            if newCurrentSum <= k {
                //If the current sum is less than k
                //the current element is added as element of the subset
                // and the function is called again with this new subset and sum
                subset.append(element)
                getKSubsets(elements: elements,
                            k: k, subset: &subset,
                            index: i + 1,
                            currentSum: newCurrentSum,
                            resultSubsets: &resultSubsets)
                // Remove the inserted element if necessary
                if subset.last == element {
                    subset.removeLast()
                }
            } else {
                // Since the elements are sorted, if the addition of the next element exceeds
                // k, any further element will exceed it too.
                return
            }
        }
    }
}

func getKSubsets(elements:[Int], k: Int) -> [[Int]] {
    var resultSubsets = [[Int]]()
    let sortedElements = elements.sorted()
    var subset = [Int]()
    getKSubsets(elements: sortedElements, k: k, subset: &subset, index: 0, currentSum: 0, resultSubsets: &resultSubsets)
    return resultSubsets
}


var elements = [39, 22, 15, 14, 1, 29]
var k = 30
let resultSubsets = getKSubsets(elements: elements, k: k)
print("K subsets for \(k):")
for subset in resultSubsets {
    print("\(subset)")
}


