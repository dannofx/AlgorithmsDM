import Foundation

// MARK: General implementation

enum Suit {
  case club
  case spade
  case heart
  case diamon
}

class Card {
  let value: Int
  var isFaceUp: Bool
  var isAvailable: Bool
  private(set) var suit: Suit
  
  init(suit: Suit, value: Int, faceUp: Bool = true) {
    self.value = value
    self.isFaceUp = faceUp
    self.isAvailable = true
    self.suit = suit
  }
  
  var points: Int {
    return 0
  }
}

class Deck<T: Card> {
  private(set) var cards: [T]
  private(set) var dealIndex: Int
  private(set) var faceUp: Bool
  
  init(faceUp: Bool) {
    self.cards = [T]()
    self.dealIndex = 0
    self.faceUp = faceUp
    self.reset()
  }
  
  func reset() {
  
  }
  
  func reset(with cards: [T]) {
  
  }
  
  func deal(_ number: Int = 1) -> [T] {
    return [T]()
  }
}

class Hand<T: Card> {
  private(set) var cards: [T]
  
  init(_ cards: [T] = [T]()) {
    self.cards = cards
  }
  
  var score: Int {
    return 0
  }
  
  func insertCard(_ card: T) -> Bool {
    if card.isAvailable {
      card.isAvailable = false
      self.cards.append(card)
      return true
    }
    return false
  }
  
  func reset() {
  }
}

// MARK: Blackjack implementation

class BlackJackHand: Hand<BlackJackCard>  {
  override var score: Int {
    return 0
  }
  
  var isBusted: Bool {
    return true // implement
  }
  
  var is21: Bool {
    return true // implement
  }

}

class BlackJackCard: Card {
  
  override var points: Int {
    if self.isAce {
      return 1
    } else if self.value >= 11 && self.value <= 13 {
      return 10
    } else {
      return self.value
    }
  }
  
  var isAce: Bool {
    return self.value == 1
  }
  
  var maxPoints: Int {
    if self.isAce {
      return 11
    } else {
      return self.points
    }
  }
  
  var minPoints: Int {
    if self.isAce {
      return 1
    } else {
      return self.points
    }
  }

}
