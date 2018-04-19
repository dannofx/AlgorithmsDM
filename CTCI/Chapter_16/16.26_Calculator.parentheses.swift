//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//
// Calculator
import Foundation

// MARK: Structures and extensions
enum ElementType {
    case sum
    case substraction
    case multiplication
    case division
    case number
    case opParentheses
    case clParentheses
    case unknown
    
    var isOperator: Bool {
        return self != .number &&
               self != .unknown &&
               self != .opParentheses &&
               self != .clParentheses
    }
    
    var priority: Int {
        switch self {
        case .sum, .substraction:
            return 1
        case .multiplication, .division:
            return 2
        default:
            return 0
        }
    }
}

enum Operand {
    case opParentheses
    case number(Double)
    
    var isPar: Bool {
        switch self {
        case .opParentheses:
                return true
        default:
            return false
        }
    }
    
    var number: Double? {
        switch self {
        case .opParentheses:
            return nil
        case let .number(num):
            return num
        }
    }
}

extension Character {
    var type: ElementType {
        switch self {
        case "0"..."9":
            return .number
        case "+":
            return .sum
        case "-":
            return .substraction
        case "*":
            return .multiplication
        case "/":
            return .division
        case "(":
            return .opParentheses
        case ")":
            return .clParentheses
        default:
            return .unknown
        }
    }
    
    var isOperator: Bool {
        return self.type.isOperator
    }
    
    var isDigit: Bool {
        return self.type == .number
    }
}

extension String {
    subscript(i: Int) -> Character {
        let index = self.index(self.startIndex, offsetBy: i)
        return self[index]
    }
}

// MARK: - Parsing
struct ElementIterator: IteratorProtocol {
    typealias Element = (value: String, type: ElementType)
    private var i: Int
    let expression: String
    
    init(_ expression: String) {
        self.expression = expression
        self.i = 0
    }
    
    mutating func next() -> Element? {
        if i == self.expression.count {
            return nil
        }
        let element = self.expression[i]
        if !element.isDigit {
            self.i += 1
            return ("\(element)", element.type)
        }
        var j = self.i + 1
        var number = "\(element)"
        while j < self.expression.count && self.expression[j].isDigit {
            number.append(self.expression[j])
            j += 1
        }
        self.i = j
        return (number, .number)
    }
}

//MARK: - Custom stack
struct Stack<Element> {
    private var items: [Element]
    
    init() {
        self.items = [Element]()
    }
    
    mutating func peek() -> Element? {
        return self.items.last
    }
    
    @discardableResult mutating func pop() -> Element? {
        if self.items.count > 0 {
            return self.items.removeLast()
        } else {
            return nil
        }
    }
    
    mutating func push(_ item: Element) {
        self.items.append(item)
    }
    
    var hasElements: Bool {
        return self.items.count > 0
    }
    
    var count: Int {
        return self.items.count
    }
}

// MARK: - Expression evaluation
class ExpressionEvaluator {
    var operatorsStack: Stack<ElementType>!
    var operandsStack: Stack<Operand>!
    
    func evaluate(_ expression: String) -> Double? {
        self.resetStacks()
        var elementIterator = ElementIterator(expression)
        while let operand = elementIterator.next() {
            // Get operand
            if operand.type == .number {
                self.operandsStack.push(.number(Double(operand.value)!))
            } else if operand.type == .opParentheses {
                self.operandsStack.push(.opParentheses)
                continue
            } else {
                return nil // Format error
            }
            // Process operator
            let result = processNextOperator(elementIterator: &elementIterator)
            if !result.success {
                return nil // format error
            }
            if result.end {
                break
            }

        }
        collapseTop()
        if self.operatorsStack.count == 0 && self.operandsStack.count == 1 {
            return self.operandsStack.pop()?.number
        } else {
            return nil // Format error
        }
    }
}

private extension ExpressionEvaluator {
    
    func resetStacks() {
        self.operatorsStack = Stack<ElementType>()
        self.operandsStack = Stack<Operand>()
    }
    
    func applyOperation(oper: ElementType, num1: Double, num2: Double) -> Double {
        switch oper {
        case .sum:
            return num1 + num2
        case .substraction:
            return num1 - num2
        case .multiplication:
            return num1 * num2
        case .division:
            return num1 / num2
        default:
            return 0.0 // won't happen
        }
    }
    
    func applyTopOperation() -> Bool {
        let oper = self.operatorsStack.pop()!
        guard let num2 = self.operandsStack.peek()?.number else {
            return false
        }
        self.operandsStack.pop()
        guard let num1 = self.operandsStack.peek()?.number else {
            return false
        }
        self.operandsStack.pop()
        let newNumber = applyOperation(oper: oper, num1: num1, num2: num2)
        self.operandsStack.push(.number(newNumber))
        return true
    }
    
    func collapseTop(nextOperator: ElementType? = nil) {
        while self.operatorsStack.count >= 1 {
            if nextOperator == nil || nextOperator!.priority <= self.operatorsStack.peek()!.priority {
                let valid = applyTopOperation()
                if !valid {
                    return
                }
            } else {
                return
            }
        }
    }
    
    func processNextOperator(elementIterator: inout ElementIterator) -> (success: Bool, end: Bool) {
        guard let oper = elementIterator.next()?.type else{ return (true, true) }
        if oper.isOperator {
            // Calculate pending results
            collapseTop(nextOperator: oper)
            // Add new operator
            self.operatorsStack.push(oper)
            return (true, false)
        } else if oper == .clParentheses {
            collapseTop(nextOperator: nil)
            
            guard let number = self.operandsStack.pop(), !number.isPar else {
                return (false, false) // Format error
            }
            guard let opPar = self.operandsStack.pop() else {
                return (false, false) // Format error
            }
            if !opPar.isPar {
                return (false, false) // Format error
            }
            self.operandsStack.push(number)
            return processNextOperator(elementIterator: &elementIterator)
        } else {
            return (false, false) // Format error
        }
    }
}



// MARK - Test
let expEv = ExpressionEvaluator()
let expression = "((1+3)/4*8)*10+11"//"1+6*3/2"
if let result = expEv.evaluate(expression) {
    print("Result: ")
    print("\(expression) = \(result)")
} else {
    print("Error: expression \(expression) couldn't be evaluated, maybe it has a syntax error and/or forbidden character.")
}
