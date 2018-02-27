//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Hash Table

import Foundation

class HashTable<Key: Hashable, Element> {
    private var nodes: [HashItem?]
    
    init(size: Int) {
        self.nodes = [HashItem?](repeating: nil, count: size)
    }
    
    func hashIndex(_ key: Key) -> Int {
        return abs(key.hashValue % self.nodes.count)
    }
}

// MARK: - HashItem (It's the node)
extension HashTable {
    
    private class HashItem {
        private(set) var next: HashItem?
        private(set) var key: Key
        private(set) var value: Element
        
        init(key: Key, value: Element) {
            self.key = key
            self.value = value
        }
        
        func changeOrAppendAtTheEnd(key: Key, value: Element) {
            if self.key == key {
                self.value = value
                return
            }
            if let next = self.next {
                next.changeOrAppendAtTheEnd(key: key, value: value)
            } else {
                self.next = HashItem(key: key, value: value)
            }
        }
        
        func removeItem(withKey key: Key) -> HashItem? {
            if self.key == key {
                let next = self.next
                self.next = nil
                return next
            } else {
                self.next = self.next?.removeItem(withKey: key)
                return self
            }
        }
        
        func findItem(withKey key: Key) -> HashItem? {
            if self.key == key {
                return self
            } else {
                return self.next?.findItem(withKey: key)
            }
        }
        
    }
}
// MARK: - Setters and getters
extension HashTable {
    subscript(key: Key) -> Element? {
        get {
            let index = self.hashIndex(key)
            return self.nodes[index]?.findItem(withKey: key)?.value
        }
        
        set(newValue) {
            let index = self.hashIndex(key)
            if let newValue = newValue {
                // Wants to add the value or change it
                if let node = self.nodes[index] {
                    node.changeOrAppendAtTheEnd(key: key, value: newValue)
                } else {
                    let newNode = HashItem(key: key, value: newValue)
                    self.nodes[index] = newNode
                }
            } else {
                // Is nil, so wants to delete the item
                self.nodes[index] = self.nodes[index]?.removeItem(withKey: key)
            }
        }
    }
}

// MARK: - Iterator
extension HashTable: Sequence {
    typealias Iterator = HashtableIterator
    
    struct HashtableIterator: IteratorProtocol {
        
        private let hashTable: HashTable
        private var node: HashItem?
        private var index: Int
        
        init(hashTable: HashTable) {
            self.hashTable = hashTable
            self.index = 0
        }
        
        mutating func next() -> (Key, Element)? {
            if let node = self.node {
                self.node = node.next
                return (node.key, node.value)
            } else {
                while self.index < self.hashTable.nodes.count {
                    if let nextNode = self.hashTable.nodes[self.index] {
                        self.node = nextNode.next
                         self.index += 1
                        return (nextNode.key, nextNode.value)
                    }
                    self.index += 1
                }
                return nil
            }
        }
    }
    
    func makeIterator() -> HashTable<Key, Element>.Iterator {
        return HashtableIterator(hashTable: self)
    }
}

// Tests
var hashTable = HashTable<String, Int>(size: 3)
hashTable["a"] = 1
hashTable["a"] = 2
hashTable["a"] = 3
hashTable["a"] = 4
hashTable["a"] = 5
hashTable["a"] = 6
hashTable["a"] = nil
hashTable["b"] = 7
hashTable["c"] = 8
hashTable["d"] = 9
hashTable["e"] = 10
hashTable["f"] = 11
hashTable["g"] = 12
hashTable["h"] = 13
hashTable["i"] = 14

for (key, value) in hashTable {
    print("\(key): \(value)")
}
let key = "a"
print("Value access for \(key): \(String(describing: hashTable[key]))")




