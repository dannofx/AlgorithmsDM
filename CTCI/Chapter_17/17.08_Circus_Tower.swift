//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Circus Tower

import Foundation

// MARK: - Person structure

struct Person: Comparable {
    let weight: Int
    let height: Int
    
    init(weight: Int, height: Int) {
        self.weight = weight
        self.height = height
    }
    
    func canBeAbove(_ other: Person) -> Bool{
        return  other.weight < self.weight &&
                other.height < self.height
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.height == rhs.height &&
               lhs.weight == rhs.weight
    }
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        if lhs.height == rhs.height {
            return lhs.weight > rhs.weight
        } else {
            return lhs.height > rhs.height
        }
    }
}

// MARK: - Find longest sequence

func findLongesSequence(people: [Person], maxSequences: inout [[Person]], to index: Int) -> [Person] {
    var maxSequence = [Person]()
    let currentPerson = people[index]
    for i in 0..<index {
        let sequence = maxSequences[i]
        if sequence.last!.canBeAbove(currentPerson) &&
            maxSequence.count < sequence.count {
            maxSequence = sequence
        }
    }
    maxSequence.append(currentPerson)
    maxSequences.append(maxSequence)
    return maxSequence
}

func findLongestSequence(_ people: [Person]) -> [Person] {
    precondition(people.count > 0)
    // Sort by height
    let sortedPeople = people.sorted()
    var maxSequences = [[Person]]()
    var maxSequence = [Person]()
    for i in 0..<sortedPeople.count {
        let sequence = findLongesSequence(people: sortedPeople, maxSequences: &maxSequences, to: i)
        if sequence.count > maxSequence.count {
            maxSequence = sequence
        }
    }
    return maxSequence
}

// MARK: - Test

let people = [
                Person(weight: 2, height: 30),
                Person(weight: 3, height: 33),
                Person(weight: 50, height: 5),
                Person(weight: 50, height: 52),
                Person(weight: 25, height: 4),
                Person(weight: 30, height: 5)
             ]
let longestSequence = findLongestSequence(people)
print("Available people: ")
print(people)
print("Longest possible sequence")
print(longestSequence)

