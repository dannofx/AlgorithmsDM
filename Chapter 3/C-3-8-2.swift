// Chapter 3, 3.8.2 Where’s Waldorf?

import Foundation

var matrix = [[Character]]()
var words = [[Character]]()

func addInputRow(_ inputRow: String) {
    let inputArray = Array(inputRow.lowercased().characters)
    matrix.append(inputArray)
}

func addInputWord(_ inputWord: String) {
    let inputArray = Array(inputWord.lowercased().characters)
    words.append(inputArray)
}

addInputRow("abcDEFGhigg")
addInputRow("hEbkWalDork")
addInputRow("FtyAwaldORm")
addInputRow("FtsimrLqsrc")
addInputRow("byoArBeDeyv")
addInputRow("Klcbqwikomk")
addInputRow("strEBGadhrb")
addInputRow("yUiqlxcnBjf")

addInputWord("Waldor")
addInputWord("Bambi")
addInputWord("Betty")
addInputWord("Dagbert")

var results = [(Int, Int)](repeating: (-1, -1), count: words.count)



func find(word: [Character]) -> (Int, Int)?{
    for x in 0..<matrix[0].count {
        for y in 0..<matrix.count {
            for direction_x in -1...1 {
                for direction_y in -1...1 {
                    if direction_y == 0 && direction_y == direction_x {
                        continue
                    }
                    let found = find(word: word, x: x, y: y, direction_x: direction_x, direction_y: direction_y)
                    if found {
                        return (x, y)
                    }
                }
            }
        }
    }
    return nil
}

func find(word: [Character], x: Int, y: Int, direction_x: Int, direction_y: Int) -> Bool{
    var cx = x
    var cy = y
    let lastcx = (cx + word.count*direction_x)
    let lastcy = (cy + word.count*direction_y)
    if  lastcx < 0 || lastcy < 0 || lastcx >= matrix[0].count || lastcy >= matrix.count  {
        return false
    }
    for i in 0..<word.count {
        if cx < 0 || cy < 0 || cx >= matrix[0].count || cy >= matrix.count {
            return false
        }
        let char = matrix[cy][cx]
        if char != word[i] {
            return false
        }
        cx += direction_x
        cy += direction_y
    }
    return true
}

for i in 0..<words.count {
    let word = words[i]
    if let result = find(word: word) {
        results[i] =  (result.1 + 1, result.0 + 1)// Format
    }
    print("Result \(i): \(results[i])")
}