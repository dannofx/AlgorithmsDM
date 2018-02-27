func calculateWinner(_ goal: Int) -> String {
  let stan = "Stan"
  let ollie = "Ollie"
  let factors = Array(stride(from: 9, through: 2, by: -1))
  var previous = goal
  var aux = -1
  var turn = 0
  while previous != 1 {
    if aux == previous {
      turn += 1
      break
    }
    aux = previous
    for factor in factors {
      if previous % factor == 0 {
        previous = previous / factor
        break
      }
    }
    turn += 1
  }
  
  return ( turn % 2 == 1 ) ? stan : ollie
}

var winner = calculateWinner(162)
print("Winner: \(winner)")
winner = calculateWinner(17)
print("Winner: \(winner)")
winner = calculateWinner(34012226)
print("Winner: \(winner)")

