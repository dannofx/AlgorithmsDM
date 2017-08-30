var dividend = -10
var divisor = 2

func divide(_ dividend: Int, _ divisor: Int) -> Int {
  var remainder = dividend
  var result = 0
  let result_sign = (dividend * divisor) > 0 ? 1 : -1
  let remainder_factor = ((dividend >= 0 && divisor > 0) || (dividend <= 0 && divisor < 0)) ? -1 : 1
  while abs(remainder) >= abs(divisor) {
    result += 1 * result_sign
    remainder = remainder + divisor * remainder_factor
  }
  return result
}
let result = divide(dividend, divisor)
print("Result \(dividend)/\(divisor): \(result)")