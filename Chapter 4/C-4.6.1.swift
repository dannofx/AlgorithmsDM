// Chapter 4, Challenge 4.6.1
//Vito's Family

func quicksort<E: Comparable>(_ a: [E]) -> [E] {
  if a.count == 0 {
    return a
  }
  let pivot = a[a.count / 2]
  let first = a.filter { $0 < pivot }
  let middle = a.filter { $0 == pivot }
  let last = a.filter {$0 > pivot} 
  return quicksort(first) + middle + quicksort(last)
}

var input = [2,2,4]
var sorted = quicksort(input)
var res = ( sorted.last! - sorted.first! )
print("Distance \(input): \(res)")
input = [3,2,4,6]
sorted = quicksort(input)
res = ( sorted.last! - sorted.first! )
print("Distance \(input): \(res)")
