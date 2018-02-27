let i = 900
let j = 1000

func applyOperation(_ i: Int, _ j: Int) -> Int {
  var maxLen = 0
  for k in i...j {
    var current = k
    var len = 1
    while current != 1 {
      current = current % 2 > 0 ? (current * 3 + 1) : current / 2
      len += 1
    }
    if len > maxLen {
      maxLen = len
    }
  }
  return maxLen
}

applyOperation(i, j)