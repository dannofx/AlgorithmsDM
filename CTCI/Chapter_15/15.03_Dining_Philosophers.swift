//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Dining Philosophers

import Foundation

// MARK: Chopstick class

class Chopstick {
    let semaphore: DispatchSemaphore
    let identifier: String
    
    init(identifier: String) {
        self.identifier = identifier
        semaphore = DispatchSemaphore(value: 1)
    }
    
    func pickUp() -> Bool{
        let timeout = DispatchTime.now() + .milliseconds(10)
        let result = self.semaphore.wait(timeout: timeout)
        if result == .success {
            print("Chopstick \(self.identifier): Picked up.")
            return true
        } else {
            print("Chopstick \(self.identifier): Not picked up.")
            return false
        }
    }
    
    func putDown() {
        print("Chopstick \(self.identifier): Put down.")
        self.semaphore.signal()
    }
}

// MARK: Philosopher class

class Philosopher {
    let leftChopstick: Chopstick
    let rightChopstick: Chopstick
    let identifier: String
    var isDinning: Bool
    
    init(identifier: String, leftChopstick: Chopstick, rightChopstick: Chopstick) {
        self.identifier = identifier
        self.leftChopstick = leftChopstick
        self.rightChopstick = rightChopstick
        self.isDinning = false
    }
    
    func dine() {
        self.isDinning = true
        DispatchQueue.global(qos: .userInitiated).async {
            print("Philosopher \(self.identifier) began eating.")
            var progress = 0
            while progress < 100 {
                let success = self.eat()
                if success {
                    progress += 1
                    print("Philosopher \(self.identifier) eating: \(progress)")
                }
            }
            print("Philosopher \(self.identifier) finished his dinner.")
            self.isDinning = false
        }
    }
}

private extension Philosopher {
    func eat() -> Bool{
        if self.pickUp() {
            self.chew()
            self.putDown()
            return true
        } else {
            return false
        }
    }
    func pickUp() -> Bool {
        var success = self.leftChopstick.pickUp()
        if success {
            success = self.rightChopstick.pickUp()
            if !success {
                self.leftChopstick.putDown()
            }
        }
        return success
    }
    
    func putDown() {
        self.leftChopstick.putDown()
        self.rightChopstick.putDown()
    }
    
    func chew() {
        print("Philosopher \(self.identifier) is chewing.")
    }
}

func haveDinner(number: Int) {
    if number < 2 {
        print("There must be at least 2 philosophers")
    }
    var chopsticks = [Chopstick]()
    var philosophers = [Philosopher]()
    for i in 0..<number {
        chopsticks.append(Chopstick(identifier: "\(i)"))
    }
    for i in 0..<number {
        let left = i
        let right = i < chopsticks.count - 1 ? i + 1 : 0
        let philosopher = Philosopher(identifier: "\(i)",
                                    leftChopstick: chopsticks[left],
                                    rightChopstick: chopsticks[right])
        philosophers.append(philosopher)
        philosopher.dine()
    }
    
    while philosophers.reduce(false, { $0 || $1.isDinning }) { }
    print("The dinner has concluded.")
}

haveDinner(number: 15)


