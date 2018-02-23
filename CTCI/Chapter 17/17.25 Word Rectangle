// Word Rectangle

import Foundation

// MARK: Utils

extension String {
    subscript(i: Int) -> Character {
        get {
            let index = self.index(self.startIndex, offsetBy: i)
            return self[index]
        }
    }
    
    func substring(from: Int, trough: Int? = nil) -> String{
        precondition(from >= 0 && from <= self.count)
        if from == self.count {
            return ""
        }
        let trought = trough ?? self.count - 1
        precondition(trought >= from && trought < self.count)
        let start = self.index(self.startIndex, offsetBy: from)
        let end = self.index(self.startIndex, offsetBy: trought)
        return String(self[start...end])
    }
}

// MARK: - Trie structures

enum FoundResult {
    case found
    case notFound
    case substringFound
}

class SuffixTrieNode {
    private(set) var children: [Character: SuffixTrieNode]
    let value: Character
    private(set) var isEndNode: Bool
    
    init(_ value: Character) {
        self.value = value
        self.children = [Character: SuffixTrieNode]()
        self.isEndNode = false
    }
    
    func insertString(_ string: String) {
        if string.count > 0 {
            let value = string[0]
            let childNode: SuffixTrieNode!
            if self.children[value] != nil {
                childNode = self.children[value]!
            } else {
                childNode = SuffixTrieNode(value)
                self.children[value] = childNode
            }
            let remaining = string.count > 1 ? string.substring(from: 1) : ""
            childNode.insertString(remaining)
        } else {
            self.isEndNode = true
        }
    }
    
    func search(_ string: String) -> FoundResult {
        if string.count == 0 {
            return self.isEndNode ? .found : .substringFound
        }
        let value = string[0]
        let remaining = string.substring(from: 1)
        if let child = self.children[value] {
            let found = child.search(remaining)
            return found
        }
        return .notFound
    }
}

class SuffixTrie {
    let root: SuffixTrieNode
    
    init() {
        root = SuffixTrieNode("^") // doesn't matter the value for the root node
    }
    
    convenience init(strings: Set<String>) {
        self.init()
        for string in strings {
            self.insertString(string)
        }
    }
    
    convenience init(group: WordGroup) {
        self.init()
        for string in group {
            self.insertString(string)
        }
    }
    
    func insertString(_ string: String) {
        self.root.insertString(string)
    }
    
    func search(_ string: String) -> FoundResult {
        return self.root.search(string)
    }
}

// MARK: - Word Group Structure

class WordGroup: Sequence {
    private var words: Set<String>
    
    init() {
        self.words = Set<String>()
    }
    
    static func createGroups(from words: [String]) -> [WordGroup?] {
        var maxWordLength = 0
        for word in words {
            if word.count > maxWordLength {
                maxWordLength = word.count
            }
        }
        var groupList = [WordGroup?](repeating: nil, count: maxWordLength)
        for word in words {
            precondition(word.count > 0)
            let index = word.count - 1
            if groupList[index] == nil {
                groupList[index] = WordGroup()
            }
            groupList[index]!.appendWord(word)
        }
        return groupList
    }
    
    var count: Int {
        return self.words.count
    }
    
    func containsWord(_ word: String) -> Bool {
        return words.contains(word)
    }
    
    func makeIterator() -> SetIterator<String> {
        return words.makeIterator()
    }
    
    private func appendWord(_ word: String) {
        words.insert(word)
    }
}

// MARK: - Word Rectangle

struct WordRectangle {
    let width: Int
    var height: Int
    let matrix: [[Character]]
    
    init(width: Int) {
        self.width = width
        self.height = 0
        self.matrix = [[Character]]()
    }
    
    init(letters: [[Character]], width: Int, height: Int) {
        precondition(letters.count > 0)
        precondition(letters[0].count > 0)
        self.width = width
        self.height = height
        self.matrix = letters
    }
    
    func isPartial(trie: SuffixTrie) -> Bool {
        if self.matrix.count == 0 {
            return true
        }
        for column in 0..<self.width {
            let colWord = self.getColumn(column)
            if trie.search(colWord) == .notFound {
                return false
            }
        }
        return true
    }
    
    func isComplete(wordGroup: WordGroup) -> Bool {
        if self.height != self.matrix.count {
            return false
        }
        for column in 0..<self.width {
            let colWord = self.getColumn(column)
            if !wordGroup.containsWord(colWord) {
                return false
            }
        }
        return true
    }
    
    func append(word: String) -> WordRectangle? {
        if self.width != word.count {
            return nil
        }
        var newMatrix = self.matrix
        newMatrix.append(Array(word))
        let newRectangle = WordRectangle(letters: newMatrix, width: width, height: height + 1)
        return newRectangle
    }
    
    var string: String {
        var text = ""
        for row in matrix {
            text.append(String(row))
            text.append("\n")
        }
        return text
    }
    
}

private extension WordRectangle {
    
    func getColumn(_ column: Int) -> String {
        var word = ""
        for row in 0..<self.matrix.count {
            let letter = self.matrix[row][column]
            word.append(letter)
        }
        return word
    }
}

// MARK: Rectangle Finder class

class RectangleFinder {
    let maxWordLength: Int
    let wordGroups: [WordGroup?]
    var triesList: [SuffixTrie?]
    
    init(words: [String]) {
        self.wordGroups = WordGroup.createGroups(from: words)
        self.maxWordLength = self.wordGroups.count
        self.triesList = [SuffixTrie?](repeating: nil, count: self.maxWordLength)
    }
    
    func findMaxRectangle() -> WordRectangle? {
        let maxSize = self.maxWordLength * self.maxWordLength
        for size in stride(from: maxSize, to: 0, by: -1) {
            for width in 1...maxWordLength {
                if size % width == 0 {
                    let height = size / width
                    if height <= self.maxWordLength {
                        if let rectangle = findRectangle(width: width, height: height) {
                            return rectangle
                        }
                    }
                }
            }
        }
        return nil
    }
    
    func findRectangle(width: Int, height: Int) -> WordRectangle? {
        precondition(width > 0)
        precondition(height > 0)
        if width > self.maxWordLength || height > self.maxWordLength {
            return nil
        }
        if self.wordGroups[width - 1] == nil {
            return nil
        }
        guard let wordGroup = self.wordGroups[height - 1] else {
            return nil
        }
        // Creates trie if it doesnt exist yet
        if self.triesList[height - 1] == nil {
            self.triesList[height - 1] = SuffixTrie(group: wordGroup)
        }
        return self.findPartialRectangle(width: width,
                                         height: height,
                                         rectangle: WordRectangle(width: width))
    }
}

private extension RectangleFinder {
    
    func findPartialRectangle(width: Int, height: Int, rectangle: WordRectangle) -> WordRectangle? {
        guard let wordGroup = self.wordGroups[height - 1] else {
            return nil
        }
        guard let trie = self.triesList[height - 1] else {
            return nil
        }
        // Base condition
        if rectangle.height == height {
            if rectangle.isComplete(wordGroup: wordGroup) {
                return rectangle
            } else {
                return nil
            }
        }
        // Check if the completed part is invalid
        if !rectangle.isPartial(trie: trie) {
            // Won't continue with the rectangle's generation
            return nil
        }
        // Try with every available word for the next row
        for word in wordGroup {
            guard let incRectangle = rectangle.append(word: word) else {
                return nil
            }
            if let partialRect = self.findPartialRectangle(width: width,
                                                           height: height,
                                                           rectangle: incRectangle) {
                return partialRect
            }
        }
        return nil
    }
}

// MARK: - Test

let words = ["abcd", "efgh", "ijkl", "mnlo", "aeim", "bfjn", "cgkl", "dhlo", "oaoe", "lcsa", "aeas", "easy", "garbage", "think"]
let rectangleFinder = RectangleFinder(words: words)
print("Available words: \(words)")
print("Biggest word rectangle: ")
if let wordRectangle = rectangleFinder.findMaxRectangle() {
    print(wordRectangle.string)
} else {
    print("Error: A rectangle can't be generated.")
}
