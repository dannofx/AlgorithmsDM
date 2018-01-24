// Permutations without Dups

import Foundation

//MARK: - My solution
func generateAllPermutations(prefix: inout [Character], characters: inout Set<Character>) -> [String] {
    var permutations = [String]()
    if characters.count == 0 {
        permutations.append(String(prefix))
    }
    for character in characters {
        characters.remove(character)
        prefix.append(character)
        let results = generateAllPermutations(prefix: &prefix, characters: &characters)
        permutations.append(contentsOf: results)
        prefix.removeLast()
        characters.insert(character)
    }
    return permutations
}

func generateAllPermutations(_ string: String) -> [String] {
    var prefix = [Character]()
    var characters = Set<Character>.init(string)
    return generateAllPermutations(prefix: &prefix, characters: &characters)
}

//MARK: - Heap algorithm

func swap(i: Int, j: Int, array: inout [Character]) {
    let aux = array[i]
    array[i] = array[j]
    array[j] = aux
}

func generateAllHeapPermutations(n: Int, characters: inout [Character], results: inout [String]) {
    if n == 1 {
        results.append(String(characters))
    } else {
        for i in 0..<(n - 1) {
            generateAllHeapPermutations(n: n - 1, characters: &characters, results: &results)
            if n % 2 == 0 {
                swap(i: i, j: n - 1, array: &characters)
            } else {
                swap(i: 0, j: n - 1, array: &characters)
            }
        }
        generateAllHeapPermutations(n: n - 1, characters: &characters, results: &results)
    }
}

func generateAllHeapPermutations(_ string: String) -> [String] {
    var characters = [Character](string)
    var results = [String]()
    generateAllHeapPermutations(n: characters.count, characters: &characters, results: &results)
    return results
}

let string = "pazito"
let permutations = generateAllHeapPermutations(string)
print(permutations)



