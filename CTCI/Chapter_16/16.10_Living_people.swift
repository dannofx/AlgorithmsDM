//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Living people

import Foundation

func getMaxYear(popChanges: [Int]) -> (year: Int, people: Int) {
    var alivePeople = 0
    var maxAlive = -1
    var maxYear = -1
    for year in 0..<popChanges.count {
        let change = popChanges[year]
        alivePeople += change
        if alivePeople > maxAlive {
            maxAlive = alivePeople
            maxYear = year
        }
    }
    return (maxYear, maxAlive)
}

func getMaxYear(people: [(birth: Int, death: Int)], start: Int, end: Int) -> (year: Int, people: Int) {
    precondition(people.count > 0)
    precondition(start < end)
    var popChanges = [Int](repeating: 0, count: (end - start) + 1)
    for person in people {
        precondition(person.death >= person.birth)
        precondition(person.birth >= start)
        precondition(person.death <= end)
        let birth = person.birth - start
        let death = person.death - start
        popChanges[birth] += 1
        if death != (popChanges.count - 1) {
            popChanges[death + 1] -= 1
        }
    }
    let max = getMaxYear(popChanges: popChanges)
    return (max.year + start, max.people)
}

let start = 1900
let end = 2000
let people = [(1900, 1930), (1900, 1920), (1910, 1915), (1914, 1970), (1950, 1969), (1970, 1999)]
let max = getMaxYear(people: people, start: start, end: end)
print("Year with most living people: \(max.year) with \(max.people) living people")

