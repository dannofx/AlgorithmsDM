import Foundation


func isNextRepeated(_ index: Int, nums: [Int], isLeft: Bool) -> Bool {
  let next = index + (isLeft ? -1 : 1)
  if next < 0 || next >= nums.count {
    return false
  }
  return nums[next] == nums[index]
}

func search(_ k: Int, nums: [Int], start: Int, end: Int, isLeft: Bool) -> Int? {
  if start > end {
    return nil
  }
  var isLast = true
  let mid = (end - start) / 2 + start
  if nums[mid] == k {
    isLast = !isNextRepeated(mid, nums: nums, isLeft: isLeft)
    
    if isLast {
      return mid
    }
  }
  let searchOnLeft = k < nums[mid] || (!isLast && isLeft)
  if searchOnLeft {
    return search(k, nums: nums, start: start, end: mid - 1, isLeft: isLeft)
  } else {
    return search(k, nums: nums, start: mid + 1, end: end, isLeft: isLeft)
  }
}

func search(_ k: Int, in nums: [Int]) -> (left: Int, right: Int)? {
  guard let left = search(k, nums: nums, start: 0, end: nums.count - 1, isLeft: true) else {
    return nil
  }
  guard let right = search(k, nums: nums, start: left + 1, end: nums.count - 1, isLeft: false) else {
    return (left, left)
  }
  return (left, right)
}

let numbers = [0,1,2,5,5,5,5,5,5,5,5]
if let results = search(5, in: numbers) {
  print(results)
} else {
  print("No results")
}