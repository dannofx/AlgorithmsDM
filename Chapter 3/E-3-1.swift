// Chapter 3, exercise 3-1

struct Stack<Element> {
  private var elements = [Element]()
  
  mutating func push(_ element: Element) {
    elements.append(element)
  }
  
  mutating func pop() ->Element? {
    return elements.popLast()
  }
  
  func peek() -> Element? {
    return elements.last
  }
  
  var count: Int {
    return elements.count
  }
}

func checkExpressionForBalance(_ input: String) {
  var stack = Stack<Character>()
  for (index, ch) in input.characters.enumerated() {
    if ch == "(" {
      stack.push(ch)
    } else if ch == ")" {
      if stack.pop() == nil {
        print("Error: Unbalanced at index \(index)")
        return
      }
    }
    print(ch)
  }
  
  if stack.count > 0 {
    print("Error: Unbalanced expression")
  } else {
    print("The expression is balanced")
  }
}

let input = "((((hola)))))"
checkExpressionForBalance(input)

