// Call Center

import Foundation

enum EmployeeLevel: Int {
    case respondant = 0
    case manager = 1
    case director = 2
}

class Employee {
    let level: EmployeeLevel
    weak var call: Call?
    
    init(level: EmployeeLevel) {
        self.level = level
    }
    
    var isAvailable: Bool {
        return self.call  == nil
    }
    
    func canHandleCall(_ call: Call) -> Bool {
        return self.level.rawValue >= call.requiredLevel.rawValue
    }
    
    func receiveCall(_ call: Call) {
        self.call = call
    }
    
    func escalateAndReassingCall(newlevel: EmployeeLevel) {
        // Change the level of the call and add it again to the dispatch queue
        self.call?.requiredLevel = newlevel
        // TODO: Add the call to the call center dispatch queue again
        // self.delegate.dispatchCall(self.call)
        self.call?.handler = nil
        self.call = nil
    }
    
    func completeCall() {
        // Finish the call
        self.call?.end()
        self.call = nil
        // TODO: Notify that the employee is free now
        // self.delegate.markEmployeAsFree(self)
    }
}

class Call {
    var requiredLevel: EmployeeLevel
    let caller: Caller
    var handler: Employee?
    
    init(caller: Caller) {
        self.requiredLevel = .respondant
        self.caller = caller
    }
    
    func end() {
        self.handler = nil
    }
}

class Caller {
    weak var call: Call?
}

class CallCenter {
    let respondants: [Employee]
    let managers: [Employee]
    let directors: [Employee]
    var callsQueues: [EmployeeLevel: [Call]]
    
    init(respondants: Int, managers: Int, directors: Int) {
        self.respondants = [Employee].init(repeating: Employee(level: .respondant), count: respondants)
        self.managers = [Employee].init(repeating: Employee(level: .manager), count: managers)
        self.directors = [Employee].init(repeating: Employee(level: .director), count: directors)
        self.callsQueues = [EmployeeLevel: [Call]]()
        self.callsQueues[.respondant] = [Call]()
         self.callsQueues[.manager] = [Call]()
         self.callsQueues[.director] = [Call]()
    }
    
    func getHandlerForCall(_ call: Call) -> Employee? {
        // Returns the first available employee that can handle this call, if any
        return nil
    }
    
    func dispatchCall(fromCaller caller: Caller) {
        let call = Call(caller: caller)
        caller.call = call
        self.dispatchCall(call)
    }
    
    func dispatchCall(_ call: Call) {
        if let handler = self.getHandlerForCall(call) {
            call.handler = handler
            handler.receiveCall(call)
        } else {
            self.callsQueues[call.requiredLevel]!.append(call)
        }
    }
    
}
