// Deck of Cards

import Foundation

// MARK: - General deck data structures

enum Suit {
    case club
    case heart
    case spade
    case diamond
}


class CardDeck {
    private var cards: [Card]
    private var dealIndex: Int
    
    init(withCards cards: [Card]) {
        self.cards = cards
        self.dealIndex = 0
    }
    
    func shuffle() {
        // Shuffle the cards
    }
    
    func dealCard() -> Card? {
        // Deal a card if there are remaining cards
        return nil
    }
    
    func dealHand(number: Int) -> [Card]? {
        // Returns an array of cards if there are enough remaining cards
        // to return the indicated number, otherwise returs nil
        return nil
    }
    
    var remainingCards: Int {
        return self.cards.count - self.dealIndex
    }
}

class Card {
    let suit: Suit
    let intrinsicValue: Int
    var available: Bool
    
    init(suit: Suit, value: Int) {
        self.suit = suit
        self.intrinsicValue = value
        self.available = true
    }
    
    var value:Int {
        // Returns a value according to the rules of the game
        return self.intrinsicValue
    }
    
}

class Hand {
    var cards: [Card]
    
    init() {
        self.cards = [Card]()
    }
    
    var score: Int {
        //Returns the score according to the present cards
        return 0
    }
    
    func addCard(_ card: Card) {
        self.cards.append(card)
    }
}

// MARK: - Blackjack implementation

class BlackjackCard: Card {
    
    override init(suit: Suit, value: Int) {
        super.init(suit: suit, value: value)
    }
    
    override var value: Int {
        if self.isAce {
            return 1
        } else if self.isFaceCard {
            return 10
        } else {
            return self.intrinsicValue
        }
    }
    
    var minValue: Int {
        if self.isAce {
            return 1
        } else {
            return self.value
        }
    }
    
    var maxValue: Int {
        if self.isAce {
            return 11
        } else {
            return self.value
        }
    }
    
    var isAce: Bool {
        return self.intrinsicValue == 1
    }
    
    var isFaceCard: Bool {
        return self.intrinsicValue > 10 && self.intrinsicValue < 14
    }
}

class BlackjackHand: Hand {
    
    var possibleScores: [Int] {
        // The implementations can return more than 1 score,
        // because an Ace has value of 1 and 11 simultaneusly
        return [Int]()
    }
    
    var isBusted: Bool {
        return self.score > 21
    }
    
    var is21: Bool {
        return self.score == 21
    }
    
    override var score: Int {
        let scores = self.possibleScores
        var maxUnder = Int.min
        var minAbove = Int.max
        for score in scores {
            if score <= 21 {
                if score > maxUnder {
                    maxUnder = score
                }
            } else {
                if score < minAbove {
                    minAbove = score
                }
            }
        }
        return maxUnder == Int.min ? minAbove : maxUnder
    }
}
