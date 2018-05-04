//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Shuffle

import Foundation

func shuffle(array: inout [Int]) {
    for i in 0..<array.count {
        let j = Int(arc4random()) % (i + 1)
        array.swapAt(i, j)
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
