// Check for balanced parentheses

// MARK: Stack structure

struct Stack<Element> {
    private var items = [Element]()
    mutating func push(_ item: Element) {
        self.items.append(item)
    }
    mutating func pop() -> Element? {
        if items.isEmpty {
            return nil
        } else {
            return items.removeLast()
        }
    }
    
    var isEmpty: Bool {
        return self.items.isEmpty
    }
}

// MARK: Utils added to character referent to parentheses balance

extension Character {
    static let parenthesisCharacters: [(open: Character, close: Character)] = [("(",")"),("[","]"),("{","}")]
    var isOpenCharacter: Bool {
        for pair in Character.parenthesisCharacters {
            if pair.open == self {
                return true
            }
        }
        return false
    }
    var isCloseCharacter: Bool {
        for pair in Character.parenthesisCharacters {
            if pair.close == self {
                return true
            }
        }
        return false
    }
    
    func isMatchingParenthesesPair(_ closeChar: Character) -> Bool{
        for pair in Character.parenthesisCharacters {
            if pair.open == self && pair.close == closeChar {
                return true
            }
        }
        return false
    }
}

// MARK: Utils added to String referent to parentheses balance

extension String {
    var isParenthesesBalanced: Bool {
        var stack = Stack<Character>()
        let characters = Array(self.characters)
        for char in characters {
            if char.isOpenCharacter {
                stack.push(char)
            } else if char.isCloseCharacter {
                guard let openChar = stack.pop() else {
                    return false
                }
                if !openChar.isMatchingParenthesesPair(char) {
                    return false
                }
            }
        }
        
        return stack.isEmpty
    }
}

// Test
let expression = "[{()}][()]"
print("Expression (\(expression) is balanced? \(expression.isParenthesesBalanced)")



