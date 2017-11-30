// Skip List
import Foundation

//// Vars used to debug (repeat the same random values in all runs
//let rresults: [Int] = [0,1,0,0,0,3,0,1,0,0]
//var rrindex: Int = 0

class Node<Element> where Element: Comparable{
    let key: Element
    var forward: [Node<Element>]
    var level: Int
    
    init(key: Element, level: Int) {
        self.key = key
        self.forward = [Node<Element>]()
        self.level = level
    }
}

class SkipList<Element> where Element: Comparable {
    let maxLevel: Int
    let p: Float
    var level: Int
    let header: Node<Element>
    
    init(maxLevel: Int, p: Float, minimumExcludedValue excludedKey: Element) {
        self.maxLevel = maxLevel
        self.p = p
        self.level = 0
        self.header = Node(key: excludedKey, level: 0)
    }
    func randomLevel() -> Int {
//        //Use this variables to debug with same random values in all runs
//        let rlevel = rresults[rrindex]
//        rrindex += 1
        
        var rlevel = 0
        var r = Float(arc4random()) / Float(UInt32.max)
        while r < p && rlevel < self.maxLevel {
            rlevel += 1
             r = Float(arc4random()) / Float(UInt32.max)
        }
        //print("rl: \(rlevel)")
        return rlevel
    }
    
    func createNode(key: Element, level: Int) -> Node<Element> {
        return Node(key: key, level: level)
    }
    
    
    func insertElement(_ key: Element) {
        // Find the path to the node to insert and the last node before
        var (current, update) = findPathToKey(key)
        // The insertion must be done if there is a free position next to the current or
        // the next key is different to the key to insert
        let shouldInsert = current.forward.count == 0 || current.forward[0].key != key
        if shouldInsert {
            let randomLevel = self.randomLevel()
            let newNode = Node(key: key, level: randomLevel)
            for i in 0...randomLevel {
                if i >= update.count {
                    update.append(header)
                    self.header.level += 1
                    self.level += 1
                }
                
                if i >= update[i].forward.count {
                    update[i].forward.append(newNode)
                } else {
                    newNode.forward.append(update[i].forward[i])
                    update[i].forward[i] = newNode
                }
            }
        } else {
            print("The key \(key) was not inserted because it already exists in the lists.")
        }
    }
    
    func findKey(_ key: Element) -> Node<Element>? {
        let (lastNode, _) = findPathToKey(key)
        if lastNode.forward.count > 0 && lastNode.forward[0].key == key {
            return lastNode.forward[0]
        } else {
            return nil
        }
    }
    
    func deleteKey(_ key: Element) {
        let (lastNode, updatePath) = findPathToKey(key)
        if lastNode.forward.count > 0 && lastNode.forward[0].key == key {
            // Update nodes references in the path
            let deleteNode = lastNode.forward[0]
            for i in 0...level {
                if updatePath[i].forward.count > i && updatePath[i].forward[i] === deleteNode {
                    if deleteNode.forward.count > i {
                        updatePath[i].forward[i] = deleteNode.forward[i]
                    } else {
                        updatePath[i].forward.remove(at: i)
                        if updatePath[i] === self.header {
                            // Update the level if necessary
                            self.header.level -= 1
                            self.level -= 1
                        }
                    }
                } else {
                    break
                }
            }
        }
    }
    
    func printList() {
        print("> Skip list")
        for i in stride(from: self.level, through: 0, by: -1) {
            var lineOutput = ""
            lineOutput.append("Level \(i): ")
            var node: Node? = self.header.forward[i]
            while let cNode = node {
                let stringKey = String(format: "%03d ", cNode.key as! CVarArg)
                lineOutput.append(stringKey)
                if cNode.forward.count <= i {
                    node = nil
                } else {
                    node = cNode.forward[i]
                }
            }
            print(lineOutput)
        }
    }
    
    private func findPathToKey(_ key: Element) -> (lastNode: Node<Element>, path:[Node<Element>]) {
        var currentNode = self.header
        // Find every previous node involved in the insertion/search in each level
        var path = [Node<Element>]()
        for i in stride(from: level, through: 0, by: -1) {
            while currentNode.forward.count > i &&
                currentNode.forward[i].key < key {
                    currentNode = currentNode.forward[i]
            }
            path.insert(currentNode, at: 0)
        }
        return (currentNode, path)
    }
}

let skipList = SkipList(maxLevel: 3, p: 0.5, minimumExcludedValue: Int.min)
skipList.insertElement(3)
skipList.insertElement(6)
skipList.insertElement(7)
skipList.insertElement(9)
skipList.insertElement(12)
skipList.insertElement(19)
skipList.insertElement(17)
skipList.insertElement(26)
skipList.insertElement(21)
skipList.insertElement(25)
skipList.printList()
let searchKey = 13
let searchResult = skipList.findKey(searchKey)
print("Exists key \(searchKey) in the list? \(searchResult != nil)")
let deleteKey = 12
skipList.deleteKey(deleteKey)
print("Removing key \(deleteKey)")
skipList.printList()


