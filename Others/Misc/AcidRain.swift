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
      res += 1
      shields[i].aLeft = res
    }
    lastX = shields[i].e
  }
  if shields.last!.e != maxX {
    res += 1
    shields.last!.aRight = 1
  }
  // adding right counter
  let total = res
  for i in 0..<shields.count {
    res = total - shields[i].aLeft
    shields[i].aRight = res
  }
}

func findMinimumPrevious(_ mShields: [[Shield]], fromRow row: Int, indexes: inout [Int]) -> Int {
  return 0
}

func findMinimumNext(_ mShields: [[Shield]], fromRow row: Int, indexes: inout [Int]) -> Int {
  return 0
}

func countMissingShields(_ mShields: [[Shield]], atRow row: Int, minX: Int, maxX: Int) -> Int {
  addMissingPerRow(mShields, atRow: row, minX: minX, maxX: maxX)
  if row == 0 {
    return mShields[row].first!.aRight + mShields[row].first!.aLeft
  }
  var rowIndexes = [Int](repeating: 0, count: row)
  var leftRest = 0 
  for i in 0..<mShields[row].count {
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


// Test 1
// let b = [1]
// let e = [2]
// let y = [1]

// Test 2
// let b = [0, 1]
// let e = [1, 3]
// let y = [100,100]

// Test 3
// let b = [0, 1]
// let e = [2, 4]
// let y = [1, 2]

// Test 4
let b = [1, 0, 3, 5]
let e = [4, 3, 5, 6]
let y = [10, 3, 1000, 8]

let shields = saveHarvest(b, e, y)
print("Shields \(shields)")