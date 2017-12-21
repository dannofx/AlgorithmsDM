// Build Order

import Foundation

class Node<Element: Comparable> {
    enum NodeState {
        case noVisited
        case visiting
        case visited
    }
    let value: Element
    var edges: [Node]
    var state: NodeState
    
    init(value: Element) {
        self.value = value
        self.edges = [Node]()
        self.state = .noVisited
    }
    
}

class DependencyGraph<T> where T: Comparable, T: Hashable {

    var projects: [Node<T>]
    
    init() {
        projects = [Node<T>]()
    }
    
    func addNode(withValue value: T) {
        let node = Node<T>(value: value)
        projects.append(node)
    }

    func addDependency(dependencyValue: T, projectValue: T) {
        guard let dependency = (projects.filter{ $0.value == dependencyValue }.first) else {
            return
        }
        guard let project = (projects.filter{ $0.value == projectValue }.first) else {
            return
        }
        project.edges.append(dependency)
        
    }
    
    func findCompilationOrder() -> [Node<T>]? {
        var orderList = [Node<T>]()
        for project in self.projects {
            if project.state == .noVisited {
                let success = self.findDFSOrder(project: project, orderList: &orderList)
                if !success {
                    return nil
                }
            }
        }
        return orderList
    }
    
    private func findDFSOrder(project: Node<T>, orderList: inout [Node<T>]) -> Bool{
        if project.state == .visiting {
            return false
        }
        if project.state == .noVisited {
            project.state = .visiting
            for dependency in project.edges {
                let success = self.findDFSOrder(project: dependency, orderList: &orderList)
                if !success {
                    return false
                }
            }
            project.state = .visited
            orderList.append(project)
        }
        return true
    }
}

let graph = DependencyGraph<String>()

graph.addNode(withValue: "a")
graph.addNode(withValue: "b")
graph.addNode(withValue: "c")
graph.addNode(withValue: "d")
graph.addNode(withValue: "e")
graph.addNode(withValue: "f")

graph.addDependency(dependencyValue: "a", projectValue: "d")
graph.addDependency(dependencyValue: "f", projectValue: "b")
graph.addDependency(dependencyValue: "b", projectValue: "d")
graph.addDependency(dependencyValue: "f", projectValue: "a")
graph.addDependency(dependencyValue: "d", projectValue: "c")
if let order = graph.findCompilationOrder() {
    print("Compilation order: ")
    print(order.flatMap{ $0.value })
} else {
    print("A valid order could not be found")
}








