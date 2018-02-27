// Operations

import Foundation

infix operator --: AdditionPrecedence // Substraction
infix operator **: AdditionPrecedence // Multiplication
infix operator |/: AdditionPrecedence // Division

extension Int {
    
    var negated: Int {
        let decrement = self < 0 ? 1 : -1
        var negated = 0
        var substraction = decrement
        var remaining = self
        while remaining != 0 {
            if ((remaining + substraction) < 0) == (remaining > 0) {
                substraction = decrement
            }
            remaining += substraction
            negated += substraction
            substraction += substraction
        }
        return negated
    }
    
    var absolute: Int {
        if self < 0 {
            return self.negated
        } else {
            return self
        }
    }
    
    static func --(lhs: Int, rhs: Int) -> Int {
        return lhs + rhs.negated
    }
    
    static func **(lhs: Int, rhs: Int) -> Int {
        let limit = lhs.absolute
        if limit > rhs.absolute {
            return rhs ** lhs
        }
        var result = 0
        for _ in 0..<limit {
            result += rhs
        }
        if lhs >= 0 {
            return result
        } else {
            return result.negated
        }
    }
    
    static func |/(lhs: Int, rhs: Int) -> Int {
        precondition(rhs != 0)
        let limit = lhs.absolute
        let addition = rhs.absolute
        var division = 0
        var current = 0
        while (current + addition) <= limit{
            current += addition
            division += 1
        }
        if (lhs > 0) == (rhs > 0) {
            return division
        } else {
            return division.negated
        }
    }
}
let a = 21
let b = -5
print("Operations for \(a) OP \(b):")
print("Sum: \(a + b)")
print("Substraction: \(a -- b)")
print("Multiplication: \(a ** b)")
print("Division: \(a |/ b)")

