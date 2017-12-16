// Animal Shelter

import Foundation

protocol QueueDelegate {
    associatedtype Element
    mutating func add(_ element: Element)
    mutating func remove() -> Element?
    mutating func peek() -> Element?
    func isEmpty() -> Bool
    var count: Int { get }
}

struct Queue<T>: QueueDelegate {
    typealias Element = T
    
    class QueueItem<T> {
        var next: QueueItem?
        let value: T
        
        init(value: T, last: QueueItem?) {
            self.value = value
            if let last =  last {
                last.next = self
            }
        }

    }
    
    var last: QueueItem<T>?
    var head: QueueItem<T>?
    private(set) var count: Int
    
    init() {
        self.count = 0
    }
    
    mutating func add(_ element: Element) {
        let newNode = QueueItem(value: element, last: last)
        self.last = newNode
        if self.head == nil {
            self.head = newNode
        }
        self.count += 1
    }
    
    mutating func remove() -> Element? {
        guard let removeNode = self.head else {
            return nil
        }
        self.head = removeNode.next
        if self.last === removeNode {
            self.last = nil
        }
        self.count -= 1
        return removeNode.value
    }
    
    func peek() -> Element? {
        return self.head?.value
    }
    
    func isEmpty() -> Bool {
        return self.count == 0
    }
}

enum AnimalType {
    case dog
    case cat
    
    var name: String {
        switch self {
        case .dog:
            return "Dog"
        case .cat:
            return "Cat"
        }
    }
}

class Animal: CustomStringConvertible {
    let type: AnimalType
    let name: String
    var sequence = 0
    
    init(name: String, type: AnimalType) {
        self.type = type
        self.name = name
    }
    
    var description: String {
        return "Type: \(type.name) Name: \(self.name)"
    }
    
}

struct AnimalShelterQueue: QueueDelegate {
    typealias Element = Animal
    var catsQueue: Queue<Animal>
    var dogsQueue: Queue<Animal>
    var sequence: Int

    init() {
        self.catsQueue = Queue<Animal>()
        self.dogsQueue = Queue<Animal>()
        self.sequence = 0
    }

    mutating func add(_ element: Animal) {
        switch element.type {
        case .cat:
            self.catsQueue.add(element)
        case .dog:
            self.dogsQueue.add(element)
        }
        element.sequence = sequence
        sequence += 1
    }

    mutating func remove() -> Animal? {
        guard let cat = self.catsQueue.peek() else {
            return self.dogsQueue.remove()
        }
        guard let dog = self.dogsQueue.peek() else {
            return self.catsQueue.remove()
        }
        return cat.sequence < dog.sequence ? self.catsQueue.remove() : self.dogsQueue.remove()
    }

    func peek() -> Animal? {
        guard let cat = self.catsQueue.peek() else {
            return self.dogsQueue.peek()
        }
        guard let dog = self.dogsQueue.peek() else {
            return self.catsQueue.peek()
        }
        return cat.sequence < dog.sequence ? cat : dog
    }

    func isEmpty() -> Bool {
        return self.catsQueue.count == 0 && self.dogsQueue.count == 0
    }

    var count: Int {
        return self.catsQueue.count + self.dogsQueue.count
    }
    
    mutating func removeDog() -> Animal? {
        return self.dogsQueue.remove()
    }
    
    mutating func removeCat() -> Animal? {
        return self.catsQueue.remove()
    }
    
    mutating func addCat(name: String) {
        let animal = Animal(name: name, type: .cat)
        self.add(animal)
    }
    
    mutating func addDog(name: String) {
        let animal = Animal(name: name, type: .dog)
        self.add(animal)
    }
}

var shelterQueue = AnimalShelterQueue()
shelterQueue.addCat(name: "cat 1")
shelterQueue.addCat(name: "cat 2")
shelterQueue.addCat(name: "cat 3")
shelterQueue.addDog(name: "dog 4")
shelterQueue.addCat(name: "cat 5")
shelterQueue.addDog(name: "dog 6")
shelterQueue.addCat(name: "cat 7")
shelterQueue.addCat(name: "cat 8")
shelterQueue.addDog(name: "dog 9")
shelterQueue.addDog(name: "dog 10")
shelterQueue.addDog(name: "dog 11")
shelterQueue.addCat(name: "cat 12")

let limit = 5
print("Removing first \(limit) the animals:")
for _ in 0..<limit {
    let animal = shelterQueue.remove()!
    print("OUT \(animal)")
}

print("Removing cats:")
while let animal = shelterQueue.removeCat() {
    print("OUT \(animal)")
}

print("Removing dogs:")
while let animal = shelterQueue.removeDog() {
    print("OUT \(animal)")
}




