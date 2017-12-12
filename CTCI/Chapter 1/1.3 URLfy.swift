// URLify

import Foundation

func URLfy(text: inout [Character]) {
    var spacesCount = text.reduce(0) { (result, character) -> Int in
        if character == " " {
            return result + 1
        } else {
            return result
        }
    }
    let originalLength = text.count
    for _ in 0..<(spacesCount * 2) {
        text.append(" ")
    }
    var i = originalLength - 1
    while i >= 0 {
        if text[i] == " " {
            spacesCount -= 1
            let offsettedIndex = i + spacesCount * 2
            text[offsettedIndex] = "%"
            text[offsettedIndex + 1] = "2"
            text[offsettedIndex + 2] = "0"
            i -= 1
        } else {
            text[i + spacesCount * 2] = text[i]
            i -= 1
        }
    }
}

var inputText = "Mr John Smith"
var input = Array(inputText)
print("Original input: \(inputText)")
URLfy(text: &input)
print("URLfied output: \(String(input))")


