// Boolean evaluation

import Foundation

func countEval(expression: String, result: Bool, cache: inout [String: Int]) -> Int {
    if expression.count == 0 {
        return 0
    }
    if expression.count == 1 {
        return (expression == "1") == result ? 1 : 0
    }
    let hash = "\(expression)\(result)"
    if let cached = cache[hash] {
        return cached
    }
    var ways = 0
    for i in stride(from: 1, to: expression.count, by: 2) {
        // Split expression in left and right expressions
        let operatorIndex = expression.index(expression.startIndex, offsetBy: i)
        let leftExp = String(expression[..<operatorIndex])
        let leftIndex = expression.index(operatorIndex, offsetBy: 1)
        let rightExp = String(expression[leftIndex...])
        // Get all the ways to get false or true in both expressions
        let leftTrue = countEval(expression: leftExp, result: true, cache: &cache)
        let leftFalse = countEval(expression: leftExp, result: false, cache: &cache)
        let rightTrue = countEval(expression: rightExp, result: true, cache: &cache)
        let rightFalse = countEval(expression: rightExp, result: false, cache: &cache)
        let total = (leftTrue + leftFalse) * (rightTrue + rightFalse)
        // Calculate ways to get true result for the current operator
        let expOperator = expression[operatorIndex]
        var trueWays = 0
        switch expOperator {
        case "|":
            trueWays = leftTrue * rightTrue + leftTrue * rightFalse + leftFalse * rightTrue
        case "&":
            trueWays = leftTrue * rightTrue
        case "^":
            trueWays = leftTrue * rightFalse + leftFalse * rightTrue
        default:
            break
        }
        ways += result ? trueWays : total - trueWays
    }
    cache[hash] = ways
    return ways
}

func countEval(expression: String, result: Bool) -> Int {
    var cache = [String: Int]()
    return countEval(expression: expression, result: result, cache: &cache)
}

let expression = "0&0&0&1^1|0"//"1^0|0|1"
let expResult = true//false
let ways = countEval(expression: expression, result: expResult)
print("Number of ways of parenthesizing \(expression): \(ways)")


