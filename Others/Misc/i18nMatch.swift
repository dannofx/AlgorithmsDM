import Foundation

extension String {
  
  subscript(index: Int) -> Character {
    let sIndex = self.index(self.startIndex, offsetBy: index)
    return self[sIndex]
  }
  
}

extension Character {
  var isDigit: Bool {
    return "0"..."9" ~= self
  }
}

func parse(_ pattern: String) -> [(character: Character, trailing: Int)] {
  var items = [(character: Character, trailing: Int)]()
  var i = 0
  while i < pattern.count {
    let character = pattern[i]
    var count = 0
    i += 1
    while i < pattern.count && pattern[i].isDigit {
      count = count * 10 + Int(String(pattern[i]))!
      i += 1
    }
    items.append((character, count))
  }
  return items
}

func match(text: String, pattern: String) -> Bool {
  let patternItems = parse(pattern)
  var index = 0
  for pItem in patternItems {
    if index >= text.count && text[index] != pItem.character {
      return false
    }
    index += 1
    index += pItem.trailing
  }
  return index == text.count
}

let res = match(text: "facebook", pattern: "f6k")
print(res)