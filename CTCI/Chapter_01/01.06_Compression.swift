//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// String compression

import Foundation

func compress(input: String) -> String {
    guard var lastChar = input.first else {
        return input
    }
    var result = ""
    var charCount = 0
    for character in input {
        if lastChar != character {
            result.append(lastChar)
            result.append("\(charCount)")
            charCount = 0
            lastChar = character
        }
        charCount += 1
    }
    result.append(lastChar)
    result.append("\(charCount)")
    if result.count >= input.count {
        return input
    } else {
        return result
    }
}

var input = "gooonnnaaacommmprrrreeeessssss"
var result = compress(input: input)
print("Compression for \(input): \(result)")
input = "abcdefg"
result = compress(input: input)
print("Compression for \(input): \(result)")
