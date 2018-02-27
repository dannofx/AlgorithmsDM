// Chapter 5, 9.6.2 Playing With Wheels

func pow (_ base:Int,_ power:Int) -> Int 
{
  var answer : Int = 1
  for _ in 0..<power { answer *= base }
  return answer
}

func generateNumber(bigPart: Int, smallPart: Int, digit: Int, base: Int, add: Bool) -> Int{
  let addition = add ? 1 : -1
  var nextDigit = digit + addition
  if nextDigit > 9 {
    nextDigit = 0
  } else if nextDigit < 0 {
    nextDigit = 9
  }
  nextDigit = nextDigit * base
  return bigPart + smallPart + nextDigit
}

func generateNext(_ input: Int) -> [Int]{
  var numbers = [Int]()
  for index in 1...4 {
    let bigDiv = pow(10, index)
    let smallDiv = pow(10, index - 1)
    var bigPart = Int(input / bigDiv) * bigDiv
    let remnant = (input % bigDiv )
    var digit =  Int(remnant / smallDiv)
    var smallPart = smallDiv == 1 ? 0 : remnant % smallDiv
    var number = generateNumber(bigPart: bigPart, smallPart: smallPart, digit: digit, base: smallDiv, add: true)
    numbers.append(number)
    number = generateNumber(bigPart: bigPart, smallPart: smallPart, digit: digit, base: smallDiv, add: false)
    numbers.append(number)
  }
  return numbers
}

func dfs(start: Int, target: Int, prohibitions: [Int]) -> Int{
  var queue = [(Int,Int)]()
  queue.append((start,0))
  var dictProhibitions = [Int: Bool]()
  var processed = [Int: Bool]()
  for p  in prohibitions {
    dictProhibitions[p] = true
  }
  while queue.count > 0 {
    var current = queue.removeFirst()
    let value = current.0
    let moves = current.1
    if value == target {
      return moves
    }
    let nextNumbers = generateNext(value)
    for number in nextNumbers {
      if dictProhibitions[number] == nil && processed[number] == nil{
        processed[number] = true
        queue.append((number, moves + 1))
      }
    }
  }
  
  return -1
}

var start = 8056
var target = 6508
var prohibitions = [8057, 8047, 5508, 7508, 6408]
var res = dfs(start: start, target: target, prohibitions: prohibitions)
print("Start: \(start), Target: \(target), Prohibitions: \(prohibitions)")
print("Result \(res)")
print("******")
start = 0000
target = 5317
prohibitions = [0001, 0009, 0010, 0090, 0100, 0900, 1000, 9000]
res = dfs(start: start, target: target, prohibitions: prohibitions)
print("Start: \(start), Target: \(target), Prohibitions: \(prohibitions)")
print("Result \(res)")

