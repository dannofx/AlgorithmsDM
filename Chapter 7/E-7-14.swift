// Chapter 7, Exercise 7-14

import Foundation

let input = "DOGGY"
var elements = Array(input.characters)

func generatePermutations(size: Int, characters: inout [Character]) {
    if size == 1 {
        let output = String.init(characters)
        print("permutation: \(output)")
        return
    }
    
    for i in 0..<(size - 1) {
        generatePermutations(size: size - 1, characters: &characters)
        let swapIndex = size % 2 == 0 ? i : 0
        let temp = characters[size - 1]
        characters[size - 1] = characters[swapIndex]
        characters[swapIndex] = temp
    }
    generatePermutations(size: size - 1, characters: &characters)
}

generatePermutations(size: elements.count, characters: &elements)

