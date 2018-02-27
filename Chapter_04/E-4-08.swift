// Chapter 4, Exercise 4.8
let input = [0, 1,2,3,6,7,8,9,10,11,12,13,14,15]//sorted array
let x = 5
var i = 0
var j = input.count - 1
var result = (-1, -1)
while i < j {
  let num = input[i] + input[j]
  if num > x {
    j -= 1
  } else if num < x {
    i += 1
  } else {
    result = (input[i], input[j])
    break
  }
}

print("Result: \(result.0), \(result.1)")
