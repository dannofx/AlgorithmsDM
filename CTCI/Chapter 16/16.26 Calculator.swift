// Calculator

import Foundation

// MARK: Structures and extensions

enum ElementType {
    case sum
    case substraction
    case multiplication
    case division
    case number
    case unknown
    
    var isOperator: Bool {
        return self != .number && self != .unknown
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
    
    mutating func pop() -> Element? {
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
    var numbersStack: Stack<Double>!
    
    func evaluate(_ expression: String) -> Double? {
        self.resetStacks()
        var elementIterator = ElementIterator(expression)
        while let number = elementIterator.next() {
            // Get number
            if number.type != .number { return nil } // Format error
            self.numbersStack.push(Double(number.value)!)
            // Get operator
            guard let oper = elementIterator.next()?.type else{ break }
            if !oper.isOperator { return nil } // Format error
            // Calculate pending results
            collapseTop(nextOperator: oper)
            // Add new operator
            self.operatorsStack.push(oper)
        }
        collapseTop()
        if self.operatorsStack.count == 0 && self.numbersStack.count == 1 {
            return self.numbersStack.pop()
        } else {
            return nil // Format error
        }
    }
}

private extension ExpressionEvaluator {
    
    func resetStacks() {
        self.operatorsStack = Stack<ElementType>()
        self.numbersStack = Stack<Double>()
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
    
    func applyTopOperation() {
        let oper = self.operatorsStack.pop()!
        let num2 = self.numbersStack.pop()!
        let num1 = self.numbersStack.pop()!
        let newNumber = applyOperation(oper: oper, num1: num1, num2: num2)
        self.numbersStack.push(newNumber)
    }
    
    func collapseTop(nextOperator: ElementType? = nil) {
        while self.operatorsStack.count >= 1 && self.numbersStack.count >= 2 {
            if nextOperator == nil || nextOperator!.priority <= self.operatorsStack.peek()!.priority {
                applyTopOperation()
            } else {
                return
            }
        }
    }
}



// MARK - Test

let expEv = ExpressionEvaluator()
let expression = "1+6*3/2"
if let result = expEv.evaluate(expression) {
    print("Result: ")
    print("\(expression) = \(result)")
} else {
    print("Error: expression \(expression) couldn't be evaluated, maybe it has a syntax error and/or forbidden character.")
}
