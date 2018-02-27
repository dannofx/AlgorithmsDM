// Chapter 8, Exercise 8-3

import Foundation

let matchIndex = 0
let insertIndex = 1
let deleteIndex = 2

struct Cell {
    var cost: Int = 0
    var parent: Int = 0
}

func createMatrix(pattern: [Character], text: [Character]) -> [[Cell]]{
    var m = [[Cell]].init(repeating: [Cell].init(repeating: Cell.init(), count: text.count + 1),
                          count: pattern.count + 1)
    for i in 0..<pattern.count {
        m[i][0].cost = 0
        m[i][0].parent = i > 0 ? deleteIndex : -1
    }
    for i in 0..<text.count {
        m[0][i].cost = 0
        m[0][i].parent = i > 0 ? insertIndex : -1
    }
    return m
}




func printSequence(data: (matrix: [[Cell]], i: Int, j: Int), pattern: String) {
    var i = data.i
    var j = data.j
    if i == -1 || j == -1 {
        print("Not coincidences found")
        return
    }
    let patternArray = Array(pattern.characters)
    let m = data.matrix
    var res = [Character]()
    var cell = m[i][j]
    while cell.cost != 0 {
        switch cell.parent {
        case matchIndex:
            i -= 1
            j -= 1
        case insertIndex:
            j -= 1
        case deleteIndex:
            i -= 1
        default:()
        }
        res.append(patternArray[i])
        cell = m[i][j]
    }
    res.reverse()
    print("Substring: \(String(res))")
}

func stringCompare(pattern: String, text: String) -> (matrix: [[Cell]], i: Int, j: Int) {
    let patterntArray = Array(" " + pattern.characters)
    let textArray = Array(" " + text.characters)
    var options = [0, 0, 0]
    var finalI = -1
    var finalJ = -1
    var majorCost = -1
    var m = createMatrix(pattern: patterntArray, text: textArray)
    for i in 1..<patterntArray.count {
        for j in 1..<textArray.count {
            if (patterntArray[i] == textArray[j]) {
                options[matchIndex] = m[i - 1][j - 1].cost
                options[insertIndex] = m[i][j - 1].cost
                options[deleteIndex] = m[i - 1][j].cost
                m[i][j].cost = options[matchIndex]
                m[i][j].parent = matchIndex
                for k in 1..<options.count {
                    if options[k] > m[i][j].cost {
                         m[i][j].cost = options[k]
                         m[i][j].parent = k
                    }
                }
                m[i][j].cost = m[i][j].cost + 1
                if  m[i][j].cost > majorCost {
                    finalI = i
                    finalJ = j
                    majorCost = m[i][j].cost
                }
            } else {
                m[i][j].cost = 0
                m[i][j].parent = -1
            }
        }
    }
    return (m, finalI, finalJ)
}

let text = "photograph"
let pattern = "tomography"
let data = stringCompare(pattern: pattern, text: text)
printSequence(data: data, pattern: pattern)
