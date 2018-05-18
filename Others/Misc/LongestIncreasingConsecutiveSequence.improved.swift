import Foundation

func findCorrespondingPosition(seq: [Int], start: Int, end: Int, value: Int) -> Int {
  if (end - start) <= 1 {
    return seq[start] > value ? start : start + 1
  }
  let middle = (end - start) / 2 + start
  if seq[middle] == value {
    return middle
  } else if seq[middle] > value {
    // Don't disacard middle! Still can be used as option to store the value
    return findCorrespondingPosition(seq: seq, start: start, end: middle, value: value)
  } else {
    
    // Don't disacard middle! Still can be used as option to store the value
    return findCorrespondingPosition(seq: seq, start: middle, end: end, value: value)
  }

}

func findLongestIncreasingSequenceLength(_ seq: [Int]) -> Int {
  if seq.count < 2 {
    return seq.count
  }
  var results = [Int](repeating: 0, count: seq.count)
  var len = 1
  results[0] = seq[0]
// Remember: The purpose of the algorithm is to form a subsequence and also keep that subsequence
// with the lower values possible, so always can be added another element at the end of the sequence.
  for i in 0..<seq.count {
    if seq[i] < results[0] {
      // New smallest element of the subsequence
      results[0] = seq[i]
    } else if seq[i] > results[len - 1] {
	  // Expand the length of the subsequence, because
      // all the elements in the subsequence are lower
      results[len] = seq[i]
      len += 1
    } else {
      // The element corresponds to the middle of the current subsequence.
      // Find the most proper existing element to be replaced.
      // This is, the immediate bigger element in the subsequence.
      let repIndex = findCorrespondingPosition(seq: seq, start: 0, end: len - 1, value: seq[i])
      results[repIndex] = seq[i]
    }
  }
  return len
}

let sequence = [100,0,1,101,2,3,4,102,103]//[2, 5, 3, 7, 11, 8, 10, 13, 6]
let subsequence = findLongestIncreasingSequenceLength(sequence)
print(subsequence)