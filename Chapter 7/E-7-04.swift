// Chapter 7, Exercise 7-4

import Foundation

let input = "DOGGY"
let inputElements = Array(input.characters)
let size = inputElements.count
var solution = [Character].init(repeating: " ", count: size)
var openPositions = [Character: Int]()


func addCharacterToOpenPositions(_ character: Character) {
    if let count = openPositions[character] {
        openPositions[character] = count + 1
    } else {
        openPositions[character] = 1
    }
}

func removeCharacterFromOpenPositions(_ character: Character) {
    if let remaining = openPositions[character], remaining > 1 {
        openPositions[character] = remaining - 1
    } else {
        openPositions.removeValue(forKey: character)
    }
}

func buildAnagram(currentSize: Int) {
    
    if currentSize == size {
        print("Solution: \(solution)")
        return
    }
    let keys = openPositions.keys
    for character in keys {
        solution[currentSize] = character
        removeCharacterFromOpenPositions(character)
        buildAnagram(currentSize: currentSize + 1)
        addCharacterToOpenPositions(character)
    }
    
}

for element in inputElements {
    addCharacterToOpenPositions(element)
}

buildAnagram(currentSize: 0)

