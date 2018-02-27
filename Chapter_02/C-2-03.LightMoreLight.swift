func isOn(_ n: Int) -> String {
  var i = 2
  while n % i != 0 {
    i += 1
    if n/2 < i {
      return "yes"
    }
  }
  return i == 1 ? "yes" :  "no"
}

var bulbs = 3
print("Is \(bulbs) on: \(isOn(bulbs))")
bulbs = 6241
print("Is \(bulbs) on: \(isOn(bulbs))")
bulbs = 8191
print("Is \(bulbs) on: \(isOn(bulbs))")