// Chapter 8, Exercise 8-1

import Foundation

let matchIndex = 0
let insertIndex = 1
let deleteIndex = 2
let swapIndex = 3

struct Cell {
    var cost: Int = 0
    var parent: Int = 0
}

func createMatrix(pattern: [Character], text: [Character]) -> [[Cell]]{
    var m = [[Cell]].init(repeating: [Cell].init(repeating: Cell.init(), count: text.count + 1),
                          count: pattern.count + 1)
    for i in 0..<pattern.count {
        m[i][0].cost = i
        m[i][0].parent = i > 0 ? deleteIndex : -1
    }
    for i in 0..<text.count {
        m[0][i].cost = i
        m[0][i].parent = i > 0 ? insertIndex : -1
    }
    return m
}

func matchCost(a: Character, b: Character) -> Int {
    return a == b ? 0 : 1
}

func insertCost(character: Character) -> Int {
    return 1
}

func deleteCost(character: Character) -> Int {
    return 1
}
func swapCost(pattern: [Character], text: [Character], pIndex: Int, tIndex: Int) -> Int {
    if tIndex > 0 && pattern[pIndex] == text[tIndex - 1] &&
       pIndex > 0 && text[tIndex] == pattern[pIndex - 1] {
        return 0
    }
    return 1
}

func goal(m: [[Cell]]) -> Int {
    return m[m.count - 2][m[0].count - 2].cost
}

func printPath(m: [[Cell]]) {
    var i = m.count - 2
    var j = m[0].count - 2
    var cell = m[i][j]
    while cell.parent != -1 {
        switch cell.parent {
        case matchIndex:
            print("M")
            i -= 1
            j -= 1
        case insertIndex:
            print("I")
            j -= 1
        case deleteIndex:
            print("D")
            i -= 1
        case swapIndex:
            print("S")
            i -= 1
            j -= 1
        default:()
        }
        cell = m[i][j]
    }
}

func stringCompare(pattern: String, text: String) -> [[Cell]] {
    let patterntArray = Array(" " + pattern.characters)
    let textArray = Array(" " + text.characters)
    var options = [0, 0, 0, 0]
    var m = createMatrix(pattern: patterntArray, text: textArray)
    for i in 1..<patterntArray.count {
        for j in 1..<textArray.count {
            options[matchIndex] = m[i - 1][j - 1].cost + matchCost(a: patterntArray[i], b: textArray[j])
            options[insertIndex] = m[i][j - 1].cost + insertCost(character: textArray[j])
            options[deleteIndex] = m[i - 1][j].cost + deleteCost(character: textArray[i])
            options[swapIndex] = m[i - 1][j - 1].cost + swapCost(pattern: patterntArray, text: textArray, pIndex: i, tIndex: j)
            m[i][j].cost = options[matchIndex]
            m[i][j].parent = matchIndex
            for k in 1..<options.count {
                if options[k] < m[i][j].cost {
                     m[i][j].cost = options[k]
                     m[i][j].parent = k
                }
            }
        }
    }
    return m
}

let text = "steve"
let pattern = "stvee"
let m = stringCompare(pattern: pattern, text: text)
let res = goal(m: m)
print("Cost: \(res)")
print("PATH")
printPath(m: m)
