//
//  main.swift
//  EraseMe
//
//  Created by Danno on 8/21/17.
//  Copyright © 2017 Daniel Heredia. All rights reserved.
//

import Foundation

struct Constants {
    static let hashMultiplier = 9
}

// MARK: - Hash methods

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ** : PowerPrecedence
func ** (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}
func ** (radix: Double, power: Int) -> Double {
    return pow(radix, Double(power))
}

extension String {
    var asciiArray: [UInt32] {
        return unicodeScalars.filter{$0.isASCII}.map{$0.value}
    }
}
extension Character {
    var asciiValue: UInt32 {
        let value = String(self).unicodeScalars.filter{$0.isASCII}.first?.value
        if value != nil {
            return value!
        } else {
            return 0
        }
    }
}

public func hash(array: Array<Character>) -> Double {
   // print("Initial hash for \(array)")
    var total: Double = 0
    var exponent = array.count - 1
    for i in array {
        total += Double(i.asciiValue) * (Double(Constants.hashMultiplier) ** exponent)
        exponent -= 1
    }
    
    return Double(total)
}

public func nextHash(prevHash: Double, dropped: Character, added: Character, patternSize: Int) -> Double {
    //print("Updated hash for \(added) removing \(dropped)")
    let oldHash = prevHash - (Double(dropped.asciiValue) *
        (Double(Constants.hashMultiplier) ** (patternSize - 1)))
    return Double(Constants.hashMultiplier) * oldHash + Double(added.asciiValue)
}

// MARK: - Find methods

func find(word: [Character]) -> (Int, Int){
    
    let wordHash = hash(array: word)
    let sizeX = matrix[0].count
    let sizeY = matrix.count
    var position = 1 - sizeX
    
    while position < sizeY {
        var x = 0
        var y = 0
        if position >= 0 {
            y = position
        } else {
            x = abs(position)
        }
        let invertedX = x == 0 ? sizeX - 1 : x
        let invertedY = y == 0 ? sizeY - 1 : y
        for direction_x in -1...1 {
            for direction_y in -1...1 {
                if direction_y == 0 && direction_y == direction_x {
                    continue
                }
                var (resX, resY) = find(word: word,
                                        wordHash: wordHash,
                                        x: x,
                                        y: y,
                                        direction_x: direction_x,
                                        direction_y: direction_y)
                if resX != -1 {
                    return (resX,resY)
                }
                if invertedY == y && invertedX == x {
                    continue
                }
                (resX, resY) = find(word: word,
                                    wordHash: wordHash,
                                    x: invertedX,
                                    y: invertedY,
                                    direction_x: direction_x,
                                    direction_y: direction_y)
                if resX != -1 {
                    return (resX,resY)
                }
                
            }
        }
        
        position += 1
        
    }
    

    return (-1, -1)
}

func find(word: [Character], wordHash: Double, x: Int, y: Int, direction_x: Int, direction_y: Int) -> (Int, Int){
    
    var cx = x
    var cy = y
    let lastcx = (cx + word.count*direction_x)
    let lastcy = (cy + word.count*direction_y)
    if  lastcx < 0 || lastcy < 0 || lastcx >= matrix[0].count || lastcy >= matrix.count  {
        return (-1, -1)
    }
    
    var currentHash:Double!
    var dropped: Character?
    //print("******")
    while cx >= 0 && cy >= 0 && cx < matrix[0].count && cy < matrix.count {
        if let dropped = dropped {
            // Next hash
            currentHash = nextHash(prevHash: currentHash,
                                   dropped: dropped,
                                   added: matrix[cy][cx],
                                   patternSize: word.count)
            //print("Hash hasta \(cx),\(cy), longitud: \(word.count)")
        } else {
            // Initialize hash
            var subArray = [Character]()
            for i in 0..<word.count {
                cx = x + i * direction_x
                cy = y + i * direction_y
                subArray.append(matrix[cy][cx])
                
            }
            currentHash = hash(array: subArray)
        }
        //Check hash
        let hashPosX = cx - (word.count - 1)*direction_x
        let hashPosY = cy - (word.count - 1)*direction_y
        if currentHash == wordHash {
            return (hashPosX, hashPosY)
        }
        //Prepare for next position
        dropped = matrix[hashPosY][hashPosX]
        cx += direction_x
        cy += direction_y
    }
    return (-1, -1)
}

// MARK: - Input and call for solution

var matrix = [[Character]]()
var words = [[Character]]()

func addInputRow(_ inputRow: String) {
    let inputArray = Array(inputRow.lowercased().characters)
    matrix.append(inputArray)
}

func addInputWord(_ inputWord: String) {
    let inputArray = Array(inputWord.lowercased().characters)
    words.append(inputArray)
}

addInputRow("abcDEFGhigg")
addInputRow("hEbkWalDork")
addInputRow("FtyAwaldORm")
addInputRow("FtsimrLqsrc")
addInputRow("byoArBeDeyv")
addInputRow("Klcbqwikomk")
addInputRow("strEBGadhrb")
addInputRow("yUiqlxcnBjf")

addInputWord("Waldor")
addInputWord("Bambi")
addInputWord("Betty")
addInputWord("Dagbert")

var results = [(Int, Int)](repeating: (-1, -1), count: words.count)

for i in 0..<words.count {
    let word = words[i]
    let result = find(word: word)
    results[i] =  result
    if result.0 != -1 {
        print("Result \(i): \(results[i])")
    } else {
       print("Result \(i): NOT FOUND")
    }
}