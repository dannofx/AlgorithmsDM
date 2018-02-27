//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Parens

import Foundation

func generateParens(buffer: inout [Character], remLeft: Int, remRight: Int, index: Int, results: inout [String]) {
    if remRight < remLeft || remLeft < 0 || remRight < 0 {
        return
    }
    if index == buffer.count {
        results.append(String(buffer))
        return
    }
    buffer[index] = "("
    generateParens(buffer: &buffer, remLeft: remLeft - 1, remRight: remRight, index: index + 1, results: &results)
    buffer[index] = ")"
    generateParens(buffer: &buffer, remLeft: remLeft, remRight: remRight - 1, index: index + 1, results: &results)
}

func generateParens(n: Int) -> [String]? {
    if n <= 0 {
        return nil
    }
    var buffer = [Character](repeating: "0", count: n * 2)
    let remLeft = n
    let remRight = n
    let index = 0
    var results = [String]()
    generateParens(buffer: &buffer,
                   remLeft: remLeft,
                   remRight: remRight,
                   index: index,
                   results: &results)
    return results
}

let n = 2
if let expressions = generateParens(n: n) {
    print("Possible expressions for \(n) pairs:")
    for expression in expressions {
        print(expression)
    }
} else {
    print("Error: Can't generate expressions for \(n) pairs")
}
