// Shuffle

import Foundation

func shuffle(array: inout [Int]) {
    for i in 0..<array.count {
        let j = Int(arc4random()) % array.count
        let temp = array[i]
        array[i] = array[j]
        array[j] = temp
    }
}

var deck = [Int]()
for i in 0..<52 {
    deck.append(i)
}
print("Original deck of cards: ")
print(deck)
shuffle(array: &deck)
print("Shuffled deck: ")
print(deck)
