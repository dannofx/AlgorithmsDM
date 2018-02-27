// Chapter 4, Exercise 4.36

//Consider an n × n array A containing integer elements (positive, negative, and zero). Assume that the elements in each row of A are in strictly increasing order, and the elements of each column of A are in strictly decreasing order. (Hence there cannot be two zeroes in the same row or the same column.) Describe an efficient algorithm that counts the number of occurrences of the element 0 in A. Analyze its running time.

let matrix = [
              [001,002,003,004,005],
              [010,020,033,044,055],
              [012,040,050,056,057],
              [15, 200,300,400,450],
              [30, 301,401,402,500],
              ]
let val = 57
var x = matrix[0].count - 1
var y = 0
var res: (Int, Int) = (-1, -1)
while x >= 0 && y < matrix.count {
  if val < matrix[y][x] {
    x -= 1
  } else if val > matrix[y][x] {
    y += 1
  } else {
    res = (x,y)
    break
  }
}

print("Position: \(res.0), \(res.1)")
