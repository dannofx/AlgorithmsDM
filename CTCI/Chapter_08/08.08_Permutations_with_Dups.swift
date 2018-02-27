//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Permutations with Duplicates

import Foundation

//MARK: - My solution
func generateAllPermutations(prefix: inout [Character], characters: inout [Character: Int], size: Int) -> [String] {
    var permutations = [String]()
    if prefix.count == size {
        permutations.append(String(prefix))
    }
    for (character, charCount) in characters {
        if charCount > 0 {
            characters[character] = charCount - 1
            prefix.append(character)
            let results = generateAllPermutations(prefix: &prefix, characters: &characters, size: size)
            permutations.append(contentsOf: results)
            prefix.removeLast()
            characters[character] = charCount
        }
    }
    return permutations
}

func generateCharDictionary(_ string: String) -> [Character: Int] {
    var dictionary = [Character: Int]()
    for character in string {
        if let count = dictionary[character] {
            dictionary[character] = count + 1
        } else {
            dictionary[character] = 1
        }
    }
    return dictionary
}

func generateAllPermutations(_ string: String) -> [String] {
    var prefix = [Character]()
    var characters = generateCharDictionary(string)
    return generateAllPermutations(prefix: &prefix, characters: &characters, size: string.count)
}


let string = "zaaa"
let permutations = generateAllPermutations(string)
print(permutations)



