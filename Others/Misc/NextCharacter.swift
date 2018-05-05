import Foundation

extension Character {
  var next: Character? {
    let view = String(self).unicodeScalars
    if view.count == 0 {
      return nil
    }
    let unicode = view[view.startIndex]
    guard let nextUnicode = UnicodeScalar(unicode.value + 1) else {
      return nil
    }
    return Character(nextUnicode)
  }
}

let b = Character("a").next
print(b!)