// Chapter 3, C 3-1

// Jolly jumpers

var test1 = [4,1,4,2,3]
var test2 = [5,1,4,2,-1,6]

func isHolly(_ sequence:[Int]) {
  var previous: Int?
  for v in sequence {
    if let previous = previous {
      let difference = abs(v - previous)
      if difference <= 0 || difference >= sequence.count {
          print("NOT JOLLY!!")
          return
      }
    }
    previous = v
  }
  print("IS JOLLY!")
}
isHolly(test1)
isHolly(test2)