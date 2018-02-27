//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Call In Order

import Foundation

protocol FizzBuzzPrinterProtocol {
    var counter: Int { get set }
    var maxValue: Int { get }
    func fizzBuzzPrinterDidFinishIteration(_ printer: FizzBuzzPrinter)
    
}

class FizzBuzzPrinter {
    typealias ConditionClosure = (Int) -> Bool
    typealias PrintClosure = (Int) -> String
    let conditionClosure: ConditionClosure
    let outputClosure: PrintClosure
    let dispatchQueue: DispatchQueue
    var delegate: FizzBuzzPrinterProtocol
    
    init(id: String, condition: @escaping ConditionClosure, outputClosure: @escaping PrintClosure, delegate: FizzBuzzPrinterProtocol) {
        
        self.conditionClosure = condition
        self.outputClosure = outputClosure
        self.delegate = delegate
        self.dispatchQueue = DispatchQueue(label: "call.in.order.\(id)")
    }
    
    func printValues() {
        self.dispatchQueue.async {
            while self.delegate.counter <= self.delegate.maxValue {
                let counter = self.delegate.counter
                if self.conditionClosure(counter) && counter <= self.delegate.maxValue{
                    print("\(counter): \(self.outputClosure(counter))")
                    self.delegate.counter += 1
                }
            }
            self.delegate.fizzBuzzPrinterDidFinishIteration(self)
        }
    }
}

class FizzBuzz {
    var maxValue: Int
    var counter: Int
    var printers: [FizzBuzzPrinter]
    var finishedPrinters: Int
    let semaphore: DispatchSemaphore
    
    init() {
        self.maxValue = 0
        self.counter = 0
        self.finishedPrinters = 0
        self.semaphore = DispatchSemaphore(value: 0)
        self.printers = []
        self.printers.append(FizzBuzzPrinter(id: "fizzbuzz", condition: { $0 % 3 == 0 && $0 % 5 == 0 }, outputClosure: { _ in "FizzBuzz" }, delegate: self))
        self.printers.append(FizzBuzzPrinter(id: "fizz", condition: { $0 % 3 == 0 && $0 % 5 != 0 }, outputClosure: { _ in "Fizz" }, delegate: self))
        self.printers.append(FizzBuzzPrinter(id: "buzz", condition: { $0 % 3 != 0 && $0 % 5 == 0 }, outputClosure: { _ in "Buzz" }, delegate: self))
        self.printers.append(FizzBuzzPrinter(id: "number", condition: { $0 % 3 != 0 && $0 % 5 != 0 }, outputClosure: { "\($0)" }, delegate: self))
    }
    
    func fizzBuzz(_ n: Int) {
        precondition(n > 0)
        self.maxValue = n
        self.counter = 1
        self.finishedPrinters = 0
        for printer in printers {
            printer.printValues()
        }
        self.semaphore.wait()
    }
}

extension FizzBuzz: FizzBuzzPrinterProtocol {
    func fizzBuzzPrinterDidFinishIteration(_ printer: FizzBuzzPrinter) {
        self.finishedPrinters += 1
        if self.finishedPrinters == self.printers.count {
            self.semaphore.signal()
        }
    }
}

let fizzBuzzObj = FizzBuzz()
fizzBuzzObj.fizzBuzz(200)
