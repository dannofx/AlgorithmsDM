// Chapter 4, Exercise 4.11
let input = [3,2,5,2,6,2,2,2,3,7,4,8,2,2,2,2,5,2,4,7,2,3,2,2,24]//unsorted array
var values = [Int: Int]()
for i in input {
  if let count = values[i] {
    values[i] = count + 1
  } else {
    values[i] = 1
  }
}
var result: Int?
for (key, count) in values {
  if count > input.count / 2 {
    result = key
    break
  }
}
if let result = result {
  print("Result :\(result)")
} else {
  print("Result not found")
}
