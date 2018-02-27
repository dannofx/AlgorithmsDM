// Call In Order

import Foundation

class Foo {
    var calls: Int
    private(set) var finishSemaphore: DispatchSemaphore // Semaphore used by the external method to not finish the program before time
    private let secondCallSemaphore: DispatchSemaphore
    private let thirdCallSemaphore: DispatchSemaphore
    
    init() {
        self.finishSemaphore = DispatchSemaphore(value: 0)
        self.calls = 0
        self.secondCallSemaphore = DispatchSemaphore(value: 0)
        self.thirdCallSemaphore = DispatchSemaphore(value: 0)
    }
    
    func first() {
        print("First called")
        markCall()
        self.secondCallSemaphore.signal()
    }
    
    func second() {
        self.secondCallSemaphore.wait()
        print("Second called")
        markCall()
        self.thirdCallSemaphore.signal()
    }
    
    func third() {
        self.thirdCallSemaphore.wait()
        print("Third called")
        markCall()
    }
    
    func markCall() {
        self.calls += 1
        if calls == 3 {
            self.finishSemaphore.signal()
        }
    }
}

func randomOrder(_ n: Int) -> [Int] {
    if n <= 0 {
        return [Int]()
    }
    var order: [Int] = Array(0..<n)
    for i in 0..<n {
        let j = Int(arc4random()) % n
        let temp = order[j]
        order[j] = order[i]
        order[i] = temp
    }
    return order
}

func callAsynchronously() {
    let foo = Foo()
    let order = randomOrder(3)
    print("Random order: \(order)")
    for i in order {
        DispatchQueue.global(qos: .userInitiated).async {
            switch i {
            case 0:
                foo.first()
            case 1:
                foo.second()
            default:
                foo.third()
            }
        }
    }
    foo.finishSemaphore.wait()
}

callAsynchronously()
