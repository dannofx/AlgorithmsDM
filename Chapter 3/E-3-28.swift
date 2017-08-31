// Chapter 3, Exercise 3.28

//You have an unordered array X of n integers. Find the array M containing n elements where Mi is the product of all integers in X except for Xi. You may not use division. You can use extra memory. (Hint: There are solutions faster than O(n2 ).)

var X = [2,5,4,3,7,8]
var left = [Int](repeating: 0, count: X.count)
var right = [Int](repeating: 0, count: X.count)
var results = [Int](repeating: 0, count: X.count)
var leftProduct = 1
var rightProduct = 1
for i in 0..<X.count {
  leftProduct *= X[i]
  let j = X.count - 1 - i
  rightProduct *= X[j]
  left[i] = leftProduct
  right[j] = rightProduct
}
// populate answer
for i in 0..<results.count {
  leftProduct = i >= 1 ? left[i-1] : 1
  rightProduct = i < (results.count - 1) ? right[i+1] : 1
  results[i] = leftProduct * rightProduct
}
print("Results: \(results)")