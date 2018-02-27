//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Word Transformer

import Foundation

// MARK: - String utils

extension String {
    
    subscript(i: Int) -> Character {
        get {
            let index = self.index(self.startIndex, offsetBy: i)
            return self[index]
        }
    }
    
    func replaced(at: Int, with replace: Character) -> String {
        return String(self.prefix(at)) + String(replace) + String(self.dropFirst(at + 1))
    }
}

// MARK: - Queue

class QueueNode<T> {
    let value: T
    var next: QueueNode?
    
    init(value: T) {
        self.value = value
    }
}

struct Queue<T> {
    var head: QueueNode<T>?
    var tail: QueueNode<T>?
    private(set) var size: Int
    
    init() {
        self.size = 0
    }
    
    mutating func enqueue(_ value: T) {
        let node = QueueNode(value: value)
        if self.head == nil {
            self.head = node
        }
        if let tail = self.tail {
            tail.next = node
        }
        self.tail = node
        self.size += 1
    }
    
    mutating func dequeue() -> T? {
        guard let first = self.head else {
            return nil
        }
        self.head = first.next
        if first === self.tail {
            self.tail = nil
        }
        self.size -= 1
        return first.value
    }
    
    func peek() -> T? {
        return self.head?.value
    }
    
    var isEmpty: Bool {
        return self.head == nil
    }

}

// MARK: - Graph Utils

class BFSData {
    var toVisit: Queue<PathNode>
    var visited: [String: PathNode]
    
    init(root: String) {
        self.toVisit = Queue<PathNode>()
        self.visited = [String: PathNode]()
        let rootNode = PathNode(word: root, previousNode: nil)
        toVisit.enqueue(rootNode)
        visited[root] = rootNode
    }
    
    var isFinished: Bool {
        return self.toVisit.isEmpty
    }
    
    func mergePath(with other: BFSData, atWord word: String) -> [String] {
        guard let end1 = self.visited[word] else {
            preconditionFailure()
        }
        guard let end2 = other.visited[word] else {
            preconditionFailure()
        }
        var firstPath = end1.collapse(fromRoot: true)
        let lastPath = end2.collapse(fromRoot: false)
        firstPath.removeLast()
        firstPath.append(contentsOf: lastPath)
        return firstPath
    }
}

class PathNode {
    let word: String
    let previousNode: PathNode?
    
    init(word: String, previousNode: PathNode? = nil) {
        self.previousNode = previousNode
        self.word = word
    }
    
    func collapse(fromRoot: Bool) -> [String] {
        var list = [String]()
        var currentNode: PathNode? = self
        while currentNode != nil {
            let node = currentNode!
            list.append(node.word)
            currentNode = node.previousNode
        }
        if fromRoot {
            list = list.reversed()
        }
        return list
    }
}

// MARK: - Wilcards management

func getWildcards(forWord word: String) -> [String] {
    var wildcards = [String]()
    for i in 0..<word.count {
        let wildcard = word.replaced(at: i, with: "_")
        wildcards.append(wildcard)
    }
    return wildcards
}

func convertToWilcardDictionary(words: [String]) -> [String: [String]] {
    var dictionary = [String: [String]]()
    for word in words {
        let wildcards = getWildcards(forWord: word)
        for wildcard in wildcards {
            if dictionary[wildcard] == nil {
                dictionary[wildcard] = [String]()
            }
            dictionary[wildcard]!.append(word)
        }
    }
    return dictionary
}

func findValidWords(forWord word: String, wildcardsDict: [String: [String]]) -> [String] {
    var results = [String]()
    let wildcards = getWildcards(forWord: word)
    for wildcard in wildcards {
        if let words = wildcardsDict[wildcard] {
            results.append(contentsOf: words)
        }
    }
    return results
}

// MARK: - Search

func searchOnOneLevel(searchTravel: BFSData, secondaryTravel: BFSData, wilcardsDict: [String: [String]]) -> String? {
    let last = searchTravel.toVisit.size
    var current = 0
    while current != last {
        guard let currentNode = searchTravel.toVisit.dequeue() else{
            return nil
        }
        // Check for collision
        let currentWord = currentNode.word
        if secondaryTravel.visited[currentWord] != nil {
            return currentWord
        }
        // If no collision add all the adjacent words (one letter changed words) to the pending visits list
        let validWords = findValidWords(forWord: currentWord, wildcardsDict: wilcardsDict)
        for validWord in validWords {
            if searchTravel.visited[validWord] == nil {
                let node = PathNode(word: validWord, previousNode: currentNode)
                searchTravel.toVisit.enqueue(node)
                searchTravel.visited[validWord] = node
            }
        }
        current += 1
    }
    return nil
}

func transformWord(origin: String, target: String, words: [String]) -> [String]? {
    let targetSearch = BFSData(root: origin)
    let originSearch = BFSData(root: target)
    let wildCardsDict = convertToWilcardDictionary(words: words)
    while !targetSearch.isFinished && !originSearch.isFinished {
        // First advance one level from the origin
        var collision = searchOnOneLevel(searchTravel: originSearch, secondaryTravel: targetSearch, wilcardsDict: wildCardsDict)
        if let collision = collision {
            return targetSearch.mergePath(with: originSearch, atWord: collision)
        }
        // If connextion not found, advance one level from the destiny
        collision = searchOnOneLevel(searchTravel: targetSearch, secondaryTravel: originSearch, wilcardsDict: wildCardsDict)
        if let collision = collision {
            return targetSearch.mergePath(with: originSearch, atWord: collision)
        }
    }
    return nil
}

// MARK: - Test
let words = ["damp", "demp", "daop", "lamp", "lemp", "limp", "liip", "lime", "lome", "loke", "like", "lise"]
let origin = "damp"
let target = "like"
print("Origin: \(origin)")
print("Target: \(target)")
if let path = transformWord(origin: origin, target: target, words: words) {
    print("Path found: \(path)")
} else {
    print("Error: No path found")
}


