// Chapter 3, Exercise 3-26

// Reverse the words in a sentence—i.e., “My name is Chris” becomes “Chris is name My.” Optimize for time and space.

var text: [Character] = ["M","y"," " , "n", "a", "m", "e", " ", "i", "s", " ", "C", "h", "r", "i", "s"]

var limit = text.count/2
for i in 0..<limit {
  var j = text.count - 1 - i
  let aux = text[i]
  text[i] = text[j]
  text[j] = aux
}

var wstart = 0
var previousChar: Character?
for i in 0..<text.count {
  if previousChar == " " {
    wstart = i
  }
  if text[i] == " " {
    var wend = i
    var wlimit = ( wend - wstart )/2 + wstart
    for j in wstart..<wlimit {
        var k = wend - 1 - ( j - wstart )
        let aux = text[j]
        text[j] = text[k]
        text[k] = aux
    }
  }
  previousChar = text[i]
}

print("\(text)")