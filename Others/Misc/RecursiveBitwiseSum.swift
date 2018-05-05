import Foundation
 
infix operator ++: AdditionPrecedence
 
extension Int {
  static func ++(_ lhs: Int, _ rhs: Int) -> Int {
    if lhs == 0 || rhs == 0{
      return lhs == 0 ? rhs : lhs
    }
    return (lhs ^ rhs) ++ ((lhs & rhs) << 1)
  }
}
 
print(105 ++ 90)