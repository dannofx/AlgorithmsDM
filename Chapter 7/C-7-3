// Chapter 7, Challenge 7-3

// 8.6.5 Tug of War

import Foundation

let people = [100, 90, 200]
var solution = [Bool].init(repeating: false, count: people.count)
var bestOption: (Int, Int) = (0, Int.max)

func analyzeSolution(solution: [Bool], people: [Int]) {
    var groupTrue = 0
    var groupFalse = 0
    for (i, value) in solution.enumerated() {
        if value {
            groupTrue += people[i]
        } else {
            groupFalse += people[i]
        }
    }
    if abs(groupTrue - groupFalse) < abs(bestOption.0 - bestOption.1) {
        bestOption = (groupTrue, groupFalse)
    }
}

func generateSets(people: [Int], solution: inout [Bool], currentSize: Int, membersTrue: Int) {
    if currentSize == people.count {
        analyzeSolution(solution: solution, people: people)
        return
    }
    let possibilities: [Bool]!
    let middle = Int(round(Float(people.count) / 2))
    if membersTrue >= middle {
        possibilities = [false]
    } else if ( people.count - membersTrue ) >= middle {
        possibilities = [true]
    } else {
        possibilities = [true, false]
    }
    for possibility in possibilities {
        solution[currentSize] = possibility
        let members = possibility ? membersTrue + 1 : membersTrue
        generateSets(people: people, solution: &solution, currentSize: currentSize + 1, membersTrue: members)
    }
}

generateSets(people: people, solution: &solution, currentSize: 0, membersTrue: 0)
print("Best solution: \(bestOption)")


