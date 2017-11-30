// Set partitions

// Set partitions divide the elements 1, . . . , n into nonempty subsets. There are 15 distinct set
// partitions of n = 4: {1234}, {123,4}, {124,3}, {12,34}, {12,3,4}, {134,2}, {13,24}, {13,2,4}, {14,23},
// {1,234}, {1,23,4}, {14,2,3}, {1,24,3}, {1,2,34}, and {1,2,3,4}.

import Foundation


func setPartitions(n: Int) -> [[[Int]]] {
    if n == 0 {
        var empty = [[[Int]]]()
        empty.append([[Int]]())
        return empty
    }
    
    // Obtain all the partitions for the elements of 0 to n - 1
    let partitions = setPartitions(n: n - 1)
    // Add element n as independent block for every partition
    var resultPartitions = [[[Int]]]()
    for partition in partitions {
        var resultPartition = partition
        resultPartition.append([n])
        resultPartitions.append(resultPartition)
    }
    // Add element n as part of a different block for every partition
    for partition in partitions {
        for j in 0..<partition.count {
            var resultPartition = partition
            resultPartition[j].append(n)
            resultPartitions.append(resultPartition)
        }
    }
    return resultPartitions
}

let n = 4
let results = setPartitions(n: n)
print("Partitions number: \(results.count)")
print("Partitions: ")
for result in results {
    print("\(result)")
}
