import Foundation



func findLongestIncreasingSequenceLength(_ seq: [Int]) -> Int {
  var subs = [Int](repeating: 1, count: seq.count)
  for i in 1..<subs.count {
    for j in 0..<i {
      if seq[j] < seq[i] && subs[j] >= subs[i] {
        subs[i] = subs[j] + 1
      }
    }
  }
  return subs.max()!
}

let sequence = [100,0,1,101,2,3,4,102,103]//[2, 5, 3, 7, 11, 8, 10, 13, 6]
let subsequence = findLongestIncreasingSequenceLength(sequence)
print(subsequence)