// Multi Search

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
        precondition(from >= 0 && from < self.count)
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

class TrieNode {
    private(set) var children: [Character: TrieNode]
    let value: Character
    private(set) var isEndNode: Bool
    
    init(_ value: Character) {
        self.value = value
        self.children = [Character: TrieNode]()
        self.isEndNode = false
    }
    
    func insertString(_ string: String) {
        if string.count > 0 {
            let value = string[0]
            let childNode: TrieNode!
            if self.children[value] != nil {
                childNode = self.children[value]!
            } else {
                childNode = TrieNode(value)
                self.children[value] = childNode
            }
            let remaining = string.count > 1 ? string.substring(from: 1) : ""
            childNode.insertString(remaining)
        } else {
            self.isEndNode = true
        }
    }
    
    // Method not used in this problem
    func searchString(_ string: String) -> FoundResult {
        if string.count == 0 {
            return self.isEndNode ? .found : .notFound
        }
        let value = string[0]
        let remaining = string.substring(from: 1)
        if let child = self.children[value] {
            let found = child.searchString(remaining)
            if found != .notFound {
                return found
            }
        }
        return self.isEndNode ? .substringFound : .notFound
    }
}

class Trie {
    let root: TrieNode
    
    init() {
        root = TrieNode("^") // doesn't matter the value for the root node
    }
    
    convenience init(strings: [String]) {
        self.init()
        for string in strings {
            self.insertString(string)
        }
    }
    
    func insertString(_ string: String) {
        self.root.insertString(string)
    }
    
    // Method not used in this problem
    func searchString(_ string: String) -> FoundResult {
        return self.root.searchString(string)
    }
}

// MARK: Search

func findSubstring(start: Int, big: String, root: TrieNode) -> [String] {
    var results = [String]()
    var node = root
    for i in start..<big.count {
        guard let nextNode = node.children[big[i]] else {
            break
        }
        node = nextNode
        if node.isEndNode {
            results.append(big.substring(from: start, trough: i))
        }
    }
    return results
}

func addSubstrings(_ substrings: [String], toResults results: inout [String: [Int]], forIndex index: Int) {
    for substring in substrings {
        if results[substring] == nil {
            results[substring] = [Int]()
        }
        results[substring]!.append(index)
    }
}

func searchAll(big: String, smalls: [String]) -> [String: [Int]] {
    let trie = Trie(strings: smalls)
    var results = [String: [Int]]()
    for i in 0..<big.count {
        let substrings = findSubstring(start: i, big: big, root: trie.root)
        addSubstrings(substrings, toResults: &results, forIndex: i)
    }
    return results
}

// MARK: - Test

let smalls = ["is", "ppi", "hi", "sis", "i", "ssippi"]
let big = "mississippi"
let results = searchAll(big: big, smalls: smalls)
print("Small strings: \(smalls)")
print("Big string: \(big)")
print("Results: ")
for result in results {
    let padding = result.key.count < 6 ? 6 : result.key.count
    let formattedKey = result.key.padding(toLength: padding, withPad: " ", startingAt: 0)
    print("   \(formattedKey): \(result.value)")
}

