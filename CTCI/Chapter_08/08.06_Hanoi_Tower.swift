// Hanoi Tower

import Foundation


class Stack<Element> {
    private(set) var items: [Element]
    
    init() {
        self.items = [Element]()
    }
    
    func push(_ item: Element) {
        self.items.append(item)
    }
    
    func pop() -> Element? {
        if self.isEmpty {
            return nil
        }
        return self.items.removeLast()
    }
    
    var top: Element? {
        return self.items.last
    }
    
    var isEmpty: Bool {
        return self.items.count == 0
    }
    
    var count: Int {
        return self.items.count
    }
}

func moveDisks<T>(origin: Stack<T>, destiny: Stack<T>, aux: Stack<T>, n: Int) {
    if n > 0 {
        moveDisks(origin: origin, destiny: aux, aux: destiny, n: n - 1)
        destiny.push(origin.pop()!)
        moveDisks(origin: aux, destiny: destiny, aux: origin, n: n - 1)
    }
}

func solveHanoi<T>(origin: Stack<T>, destiny: Stack<T>, aux: Stack<T>) {
    moveDisks(origin: origin, destiny: destiny, aux: aux, n: origin.count)
}

func printTower<T>(tower: Stack<T>, name: String) {
    print("Tower \(name): \(tower.count)")
    for i in stride(from: tower.count - 1, through: 0, by: -1) {
        print("\(tower.items[i])")
    }
    print("---")
}

let towerA = Stack<Int>()
let towerB = Stack<Int>()
let towerC = Stack<Int>()
for i in stride(from: 10, through: 1, by: -1) {
    towerA.push(i)
}

solveHanoi(origin: towerA, destiny: towerB, aux: towerC)

printTower(tower: towerA, name: "A")
printTower(tower: towerB, name: "B")
printTower(tower: towerC, name: "C")

