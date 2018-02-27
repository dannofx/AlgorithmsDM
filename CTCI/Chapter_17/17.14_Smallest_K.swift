// Smallest K

import Foundation

// MARK: - Utils

typealias PartitionResult = (leftSize: Int, middleSize: Int)

func swap(numbers: inout [Int], i: Int, j: Int) {
    let temp = numbers[i]
    numbers[i] = numbers[j]
    numbers[j] = temp
}

func randomIndex(start: Int, end: Int) -> Int {
    precondition(start >= 0)
    precondition(end >= start)
    let size = end - start + 1
    return start + Int(arc4random()) % size
}

// MARK: Partition (smaller left, larger right)

func partition(numbers: inout [Int], start: Int, end: Int, pivot: Int) -> PartitionResult{
    var left = start
    var right = end
    var middle = start
    // All the smaller elements will be kept from start to left (not including left)
    // and all the larger elements will be kept from right to end (not including right).
    // The index middle behaves exactly as left, with the difference,
    // that if a element with the value pivot is found it will offset by one
    // so all the elments with the value pivot will be kept between left and right (inclusive)
    while middle <= right {
        if numbers[middle] < pivot {
            swap(numbers: &numbers, i: middle, j: left)
            left += 1
            middle += 1
        } else if numbers[middle] > pivot {
            swap(numbers: &numbers, i: middle, j: right)
            right -= 1
        } else {
            middle += 1
        }
    }
    return PartitionResult(leftSize: left - start, middleSize: right - left + 1)
}

// MARK: - Rank the numbers

func rank(numbers: inout [Int], k: Int, start: Int, end: Int) -> Int{
    let pivotIndex = randomIndex(start: start, end: end)
    let pivot = numbers[pivotIndex]
    let pResult = partition(numbers: &numbers, start: start, end: end, pivot: pivot)
    if k < pResult.leftSize {
        // Left size contains more than K smallest values
        return rank(numbers: &numbers,
                    k: k,
                    start: start,
                    end: start + pResult.leftSize - 1)
    } else if k < pResult.leftSize + pResult.middleSize {
        // The numbers befor or in middle size are the K smallest values
        return pivot
    } else {
        // There are not enought smallest values on the left side
        return rank(numbers: &numbers,
                    k: k - pResult.leftSize - pResult.middleSize,
                    start: start + pResult.leftSize + pResult.middleSize ,
                    end: end)
    }
}

func findSmallest(k: Int, numbers: [Int]) -> [Int] {
    var mNumbers = numbers
    precondition(k >= 0 && k <= numbers.count)
    // Rank will put all smaller elements to the left and the larger to the right.
    // The value returned corresponds to the value in the kth + 1 element.
    let limit = rank(numbers: &mNumbers, k: k, start: 0, end: mNumbers.count - 1)
    var result = [Int]()
    for number in mNumbers {
        if number < limit {
            result.append(number)
        } else {
            break
        }
    }
    // If result doesn't have k elements is because there are several
    // elements with the value of limit, so some of those values need to be added.
    var last = result.count
    while result.count < k {
        result.append(mNumbers[last])
        last += 1
    }
    return result
}

// MARK: - Test

let numbers = [6,5,7,3,4,8,9,0,1,2,2,2,2]
let k = 5
let smallestK = findSmallest(k: k, numbers: numbers)
print(smallestK)
