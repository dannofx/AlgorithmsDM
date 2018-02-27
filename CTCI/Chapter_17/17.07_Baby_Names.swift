//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Baby Names

import Foundation

// MARK: - Node

class NameNode {
    let name: String
    let frequency: Int
    
    init(name: String, frequency: Int) {
        self.name = name
        self.frequency = frequency
    }
    
}

// MARK: - Graph

class NamesGraph {
    var nodes: [String: NameNode]
    var edges: [String: [NameNode]]
    
    init() {
        self.nodes = [String: NameNode]()
        self.edges = [String: [NameNode]]()
    }
    
    func addNameFrequencies(_ frequencies: [String: Int]) {
        for (key, value) in frequencies {
            self.addName(key, frequency: value)
        }
    }
    
    func addSynonims(_ synonims: [(name1: String, name2: String)]) {
        for value in synonims {
            self.addSynonim(value.name1, value.name2)
        }
    }
    
    func computeTrueFrequencies() -> [String: Int] {
        var frequencies = [String: Int]()
        var visited = Set<String>()
        for node in self.nodes.values {
            if !visited.contains(node.name) {
                frequencies[node.name] = computeDepthFrequency(node: node, visited: &visited)
            }
        }
        return frequencies
    }
    

}

private extension NamesGraph {
    
    func addName(_ name: String, frequency: Int) {
        if self.nodes[name] != nil {
            self.edges[name] = nil
        }
        self.nodes[name] = NameNode(name: name, frequency: frequency)
    }
    
    func addSynonim(_ name1: String, _ name2: String) {
        guard let node1 = self.nodes[name1] else {
            return
        }
        guard let node2 = self.nodes[name2] else {
            return
        }
        if self.edges[name1] == nil {
            self.edges[name1] = [NameNode]()
        }
        if self.edges[name2] == nil {
            self.edges[name2] = [NameNode]()
        }
        self.edges[name1]!.append(node2)
        self.edges[name2]!.append(node1)
    }
    
    func computeDepthFrequency(node: NameNode, visited: inout Set<String>) -> Int {
        if visited.contains(node.name) {
            return 0
        }
        var frequency =  node.frequency
        visited.insert(node.name)
        if let edges = self.edges[node.name] {
            for neighbor in edges {
                frequency += computeDepthFrequency(node: neighbor, visited: &visited)
            }
        }
        return frequency
    }
}

// MARK: Client method

func computeTrueFrequencies(frequencies: [String: Int], synonims: [(name1: String, name2: String)]) -> [String: Int] {
    let graph = NamesGraph()
    graph.addNameFrequencies(frequencies)
    graph.addSynonims(synonims)
    return graph.computeTrueFrequencies()
}

// MARK: Tests

let frequencies = ["John": 15,
                   "Jon": 12,
                   "Chris": 13,
                   "Kris": 4,
                   "Christopher": 19]
let synonims = [("Jon", "John"),
                ("John", "Johnny"),
                ("Chris", "Kris"),
                ("Chris", "Christopher")]
let trueFrequencies = computeTrueFrequencies(frequencies: frequencies, synonims: synonims)
print("Given frequencies: ")
print(frequencies)
print("Synonims: ")
print(synonims)
print("True frequencies: ")
print(trueFrequencies)
