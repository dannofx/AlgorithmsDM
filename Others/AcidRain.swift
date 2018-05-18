// Acid Rain
// 
// Problem Statement
// You are a farmer living in a 2-dimensional world. Your crops look like an infinite line parallel 
// to the x-axis, with the y-coordinate equal to 0. According to the weather forecast, the next rain will 
// be acid, and therefore very harmful to your plants. The rain consists of an infinite number of drops 
// that fall down vertically (parallel to the y-axis). For every x, where x is an arbitrary number 
// (not necessarily an integer), a drop will fall toward the point (x, 0).
// 
// To protect your crops, you have built some shields above the ground. Each shield is a line segment parallel
// to the x-axis, with negligible thickness. If a drop of rain falls on a shield, it will flow to the closest end
// of the shield and continue falling straight down vertically from that point. If a drop falls exactly in the 
// middle of a shield, the drop will divide into two equal parts that flow to opposite ends of the shield and 
// continue falling from there. If two or more shields have common endpoints they will act as one combined 
// shield. See examples for clarification.
// 
// The locations of your existing shields will be given in the three int[]s b, e and y. The endpoints of the i-th 
// shield are located at (b[i], y[i]) and (e[i], y[i]). Define B as the minimum value in b, and E as the maximum value 
// in e. Your task is to build enough additional shields to protect all the crops between (B, 0) and (E, 0), exclusive 
// (that is, all crops whose x-coordinates lie in the open interval (B, E) ). Each shield must be a line segment parallel 
// to the x-axis with non-zero length and a positive y-coordinate. Each shield you build must have integer endpoints and 
// a positive length. Build these new shields in such a way that the sum of their lengths is minimized. Return the sum of 
// the new shields' lengths.
// 
// Definition
// Class: AcidRain
// Method: saveHarvest
// Parameters: int[], int[], int[]
// Returns: int
// Method signature: int saveHarvest(int[] b, int[] e, int[] y)
// (be sure your method is public)
// Limits
// Time limit (s): 840.000
// Memory limit (MB): 64
// Constraints
// - b will contain between 1 and 25 elements, inclusive.
// - b, e and y will contain the same number of elements.
// - Each element of b will be between 0 and 10, inclusive.
// - Each element of e will be between 0 and 10, inclusive.
// - For all i, the i-th element of b will be less than the i-th element of e.
// - Each element of y will be between 1 and 100000, inclusive.
// - No two shields will overlap, but they can have common endpoints.
// 

import Foundation
 
class Shield {
  let b: Int
  let e: Int
  var aLeft: Int
  var aRight: Int
 
  init(b: Int, e: Int) {
    self.b = b
    self.e = e
    self.aLeft = 0
    self.aRight = 0
  }
  
  var middle: Double {
    let start = Double(self.b)
    let end = Double(self.e)
    return (end - start) / 2.0 + start
  }
  
  func canBeUnder(_ other: Shield, left: Bool) -> Bool {
    if left {
      let point = Double(other.b)
      return point < self.middle
    } else {
      let point = Double(other.e)
      return point > self.middle
    }
  }
}
 
func createYIndexes(_ y: [Int]) -> [Int: Int] {
  var hSet = Set<Int>()
  for elem in y {
    hSet.insert(elem)
  }
  var hArray = Array<Int>(hSet)
  hArray.sort()
  var heights = [Int: Int]()
  for i in 0..<hArray.count {
    heights[hArray[i]] = i
  }
  return heights
}
 
func convertToShields(_ b: [Int], _ e: [Int], _ y: [Int]) -> (shields: [[Shield]], minX: Int, maxX: Int) {
  let yIndexes = createYIndexes(y)
  var shields = [[Shield]](repeating:[Shield](), count: yIndexes.count)
  for i in 0..<b.count {
    let yIndex = yIndexes[y[i]]!
    let shield = Shield(b: b[i], e: e[i])
    shields[yIndex].append(shield)
  }
  var minX = Int.max
  var maxX = Int.min
  for i in 0..<shields.count {
    shields[i].sort {
      $0.b < $1.b
    }
    if minX > shields[i].first!.b {
      minX = shields[i].first!.b
    }
    if maxX < shields[i].last!.e {
      maxX = shields[i].last!.e
    }
  }
  return (shields, minX, maxX)
}
 
func addMissingPerRow(_ mShields: [[Shield]], atRow row: Int, minX: Int, maxX: Int) {
  let shields = mShields[row]
  var lastX = minX
  var res = 0
  // Adding left counter and counting
  for i in 0..<shields.count {
    if shields[i].b != lastX {
      res += shields[i].b - lastX
      shields[i].aLeft = res
    }
    lastX = shields[i].e
  }
  if shields.last!.e != maxX {
    let diff = maxX - shields.last!.e
    res += diff
    shields.last!.aRight = diff
  }
  // adding right counter
  let total = res
  for i in 0..<shields.count {
    res = total - shields[i].aLeft
    shields[i].aRight = res
  }
}

func moveIndex(under shield: Shield, row: [Shield], index: Int, left: Bool) -> Int {
  if index == row.count {
    return index
  }
  
  for i in index..<row.count {
    let other = row[i]
    if other.canBeUnder(shield, left: left) {
      return i
    }
  }
  return row.count
}
 
func findMinimumPrevious(_ mShields: [[Shield]], fromRow row: Int, indexes: inout [Int]) -> Int {
  let shield = mShields[row][indexes[row]]
  var minimum = shield.aLeft
  for row in stride(from: row - 1, through: 0, by: -1) {
    indexes[row] = moveIndex(under: shield, row: mShields[row], index: indexes[row], left: true)
    if indexes[row] == mShields[row].count {
      continue
    }
    let oShield = mShields[row][indexes[row]]
    if oShield.aLeft < minimum {
      minimum = oShield.aLeft
    }
  }
  return minimum
}
 
func findMinimumNext(_ mShields: [[Shield]], fromRow row: Int, indexes: inout [Int]) -> Int {
  let shield = mShields[row][indexes[row]]
  var minimum = shield.aRight
  for row in stride(from: row - 1, through: 0, by: -1) {
    indexes[row] = moveIndex(under: shield, row: mShields[row], index: indexes[row], left: false)
    if indexes[row] == mShields[row].count {
      continue
    }
    let oShield = mShields[row][indexes[row]]
    if oShield.aRight < minimum {
      minimum = oShield.aRight
    }
  }
  return minimum
}
 
func countMissingShields(_ mShields: [[Shield]], atRow row: Int, minX: Int, maxX: Int) -> Int {
  addMissingPerRow(mShields, atRow: row, minX: minX, maxX: maxX)
  if row == 0 {
    return mShields[row].first!.aRight + mShields[row].first!.aLeft
  }
  var rowIndexes = [Int](repeating: 0, count: row + 1)
  var leftRest = 0
  for i in 0..<mShields[row].count {
    rowIndexes[row] = i
    let shield = mShields[row][i]
    shield.aLeft = shield.aLeft - leftRest
    let newLeft = findMinimumPrevious(mShields, fromRow: row, indexes: &rowIndexes)
    if newLeft < shield.aLeft {
      leftRest += shield.aLeft - newLeft
      shield.aLeft = newLeft
    }
    let newRight = findMinimumNext(mShields, fromRow: row, indexes: &rowIndexes)
    if newRight < shield.aRight {
      return newRight + shield.aLeft
    }
  }
  return mShields[row].last!.aLeft + mShields[row].last!.aRight
}
 
 
func saveHarvest(_ b: [Int], _ e: [Int], _ y: [Int]) -> Int {
  precondition(b.count > 0)
  let (mShields, minX, maxX) = convertToShields(b, e, y)
  var minShields = Int.max
 
  for row in 0..<mShields.count {
    let added = countMissingShields(mShields, atRow:row, minX: minX, maxX: maxX)
    if added < minShields {
      minShields = added
    }
  }
  return minShields
}
 
 
// Test 0 (r: 0)
// let b = [1]
// let e = [2]
// let y = [1]

// Test 0 (r: 0)
// let b = [1, 2]
// let e = [2, 3]
// let y = [1, 1]

// Test 2 (r: 0)
// let b = [0, 1]
// let e = [1, 3]
// let y = [100,100]
 
// Test 3 (r: 1)
// let b = [0, 1]
// let e = [2, 4]
// let y = [1, 2]
 
// Test 4 (r: 2)
let b = [1, 0, 3, 5]
let e = [4, 3, 5, 6]
let y = [10, 3, 1000, 8]
 
let shields = saveHarvest(b, e, y)
print("Shields \(shields)")