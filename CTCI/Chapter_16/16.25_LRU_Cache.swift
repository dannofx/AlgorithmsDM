//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// LRU Cache

import Foundation

// MARK: - List Node

class CacheNode<Key, Value> {
    var previousNode: CacheNode?
    var nextNode: CacheNode?
    var value: Value
    let key: Key
    
    init(key: Key, value: Value) {
        self.key = key
        self.value = value
    }
}

// MARK: - Iterator for cache objects

struct CacheIterator<Key, Value>: IteratorProtocol  where Key: Hashable{
    typealias Element = (key: Key, value: Value)
    
    var currentNode: CacheNode<Key, Value>?
    
    init(_ head: CacheNode<Key, Value>?) {
        self.currentNode = head
    }
    
    mutating func next() -> (key: Key, value: Value)? {
        if let node = currentNode {
            self.currentNode = node.nextNode
            return (key: node.key, value: node.value)
        } else {
            return nil
        }
    }
}

// MARK: - Cache class

class Cache<Key, Value>: Sequence where Key: Hashable {
    typealias TCacheNode = CacheNode<Key, Value>
    let limit: Int
    private var dictionary: [Key: TCacheNode]
    private var head: TCacheNode?
    private var tail: TCacheNode?
    
    init(limit: Int) {
        precondition(limit > 0)
        self.limit = limit
        self.dictionary = [Key: TCacheNode]()
    }
    
    subscript(key: Key) -> Value? {
        get {
            return self.getValue(forKey: key)
        }
        set(newValue) {
            if let newValue = newValue {
                self.set(value: newValue, forKey: key)
            } else {
                _ = self.removeValue(forKey: key)
            }
        }
    }
    
    func makeIterator() -> CacheIterator<Key, Value> {
        return CacheIterator(self.head)
    }
}

// MARK: - Cache edition

private extension Cache {
    func set(value: Value, forKey key: Key) {
        if self.dictionary[key] != nil {
            self.removeValue(forKey: key)
        }
        self.insert(value: value, forKey: key)
    }
    
    func insert(value: Value, forKey key: Key) {
        let node = TCacheNode(key:key,value: value)
        self.dictionary[key] = node
        node.nextNode = self.head
        self.head?.previousNode = node
        self.head = node
        if self.tail == nil {
            self.tail = node
        }
        self.checkForRemoval()
    }
    
    func removeValue(forKey key: Key) {
        guard let node = self.dictionary[key] else {
            return
        }
        self.dictionary[key] = nil
        if node === self.head {
            self.head = node.nextNode
        }
        if node === self.tail {
            self.tail = node.previousNode
        }
        node.previousNode?.nextNode = node.nextNode
        node.nextNode?.previousNode = node.previousNode
        node.previousNode = nil
        node.nextNode = nil
    }
    
    func getValue(forKey key: Key) -> Value? {
        if let node = self.dictionary[key] {
            if node !== self.head {
                self.removeValue(forKey: key)
                self.insert(value: node.value, forKey: key)
            }
            return node.value
        } else {
            return nil
        }
    }
    
    func checkForRemoval() {
        if let tail = self.tail, self.dictionary.count > limit {
            self.removeValue(forKey: tail.key)
        }
    }
}

// MARK: Tests

func printAccess(cache: Cache<String, String>, key: String) {
    print("Access \(key): \(cache[key] ?? "(null)")")
}

let cache = Cache<String, String>(limit: 3)
cache["1"] = "a"
cache["2"] = "b"
printAccess(cache: cache, key: "2")
cache["3"] = "c"
printAccess(cache: cache, key: "1")
cache["4"] = "d"
printAccess(cache: cache, key: "1")
cache["5"] = "e"
cache["6"] = "f"
printAccess(cache: cache, key: "1")
cache["7"] = "g"
cache["8"] = "h"
printAccess(cache: cache, key: "2")
cache["9"] = "i"
printAccess(cache: cache, key: "4")
cache["9"] = "update"
cache["1"] = "head"
cache["8"] = nil
print("All tuples in cache: ")
for tuple in cache {
    print(tuple)
}