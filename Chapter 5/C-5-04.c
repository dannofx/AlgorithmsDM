// Chapter 5, Challenge 9.6.5 Edit Step Ladders

extension UInt32 {
    var asciiCharacter: Character? {
        guard let scalar = UnicodeScalar(self) else {
            return nil
        }
        return Character(scalar)
    }
}

extension String {
    var asciiArray: [UInt32] {
        return self.unicodeScalars.filter{$0.isASCII}.map{$0.value}
    }
}

extension Character {
    var asciiValue: UInt32? {
        return String(self).unicodeScalars.filter{$0.isASCII}.first?.value
    }
}

func generateVariations(word: String) -> [String] {
    var variations = [String]()
    let start = Character("a").asciiValue!
    let end = Character("z").asciiValue!
    let wordCharacters = Array(word.characters)
    for (wChI, wCh) in wordCharacters.enumerated() {
        
        for asciiNum in start...end {
            // Add a character
            if wordCharacters.count < 16 {
                var expandedWordCharacters = wordCharacters
                expandedWordCharacters.insert(asciiNum.asciiCharacter!, at: wChI)
                let expandedWord = String(expandedWordCharacters)
                variations.append(expandedWord)
            }
            // Change a character
            if asciiNum.asciiCharacter == wCh {
                continue
            }
            var changedWordCharacters = wordCharacters
            changedWordCharacters[wChI] = asciiNum.asciiCharacter!
            let changedWord = String(changedWordCharacters)
            variations.append(changedWord)
            
        }
        // Delete a character
        var reducedWordCharacters = wordCharacters
        reducedWordCharacters.remove(at: wChI)
        if reducedWordCharacters.count > 0 {
            variations.append(String(reducedWordCharacters))
        }
    }
    // Remaining 
    if wordCharacters.count < 16 {
        for asciiNum in start...end {
            variations.append(word + String(asciiNum.asciiCharacter!))
        }
    }
    return variations
}
func maxEditStepLadder(input: [String]) -> Int {
    var wordPathDict = [String: Int]()
    var maxLadderSize = 0
    for word in input {
        var pathLen = 0
        let variations = generateVariations(word: word)
        for variation in variations {
            if variation > word {
                continue
            }
            if let varPath = wordPathDict[variation], varPath > pathLen {
                pathLen = varPath
            }
        }
        
        pathLen += 1
        wordPathDict[word] = pathLen
        if pathLen > maxLadderSize {
            maxLadderSize = pathLen
        }
    }
    return maxLadderSize
}

let input = ["cat", "dig", "dog", "fig", "fin", "fine", "fog", "log", "wine"]
let stringInput = input.joined(separator: ", ")
let max = maxEditStepLadder(input: input)
print("Input: \(stringInput)")
print("Max edit step ladder size: \(max)")

