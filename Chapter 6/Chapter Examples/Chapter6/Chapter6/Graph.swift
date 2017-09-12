//
//  Graph.swift
//  Chapter6
//
//  Created by Danno on 9/7/17.
//  Copyright © 2017 Daniel Heredia. All rights reserved.
//

import Cocoa

// MARK: - Edge structure

class EdgeNode {
    var destinationIndex: Int
    var weight: Int
    var nextNode: EdgeNode?
    
    init(destinationIndex: Int, weight: Int) {
        self.destinationIndex = destinationIndex
        self.weight = weight
    }
    
}

// MARK: - Graph structure

struct Graph {
    private(set) var edges: [EdgeNode?]
    private(set) var degree: [Int] = []
    let vertices: Int
    let directed: Bool
    init(vertices: Int, directed: Bool) {
        self.vertices = vertices
        self.directed = directed
        self.edges = [EdgeNode?].init(repeating: nil, count: self.vertices)
        self.degree = [Int].init(repeating: 0, count: self.vertices)
    }
    
    
    mutating func addEdge(origin: Int, destination: Int, weight: Int = 0) {
        if origin >= self.vertices {
            print("Error: Origin \(origin) is out of range")
            return
        }
        if destination >= self.vertices {
            print("Error: Origin \(destination) is out of range")
            return
        }
        let edge = EdgeNode.init(destinationIndex: destination, weight: weight)
        self.add(edgeNode: edge, toVertice: origin)
    }
    
    private mutating func add(edgeNode: EdgeNode, toVertice vertice: Int, addInverted: Bool = true) {
        let previousEdge = self.edges[vertice]
        edgeNode.nextNode = previousEdge
        self.edges[vertice] = edgeNode
        self.degree[vertice] = self.degree[vertice] + 1
        if !self.directed && addInverted {
            let invertedEdge = EdgeNode.init(destinationIndex: vertice, weight: edgeNode.weight)
            self.add(edgeNode: invertedEdge, toVertice: edgeNode.destinationIndex, addInverted: false)
            
        }
    }
    
    func printGraph() {
        print("GRAPH STRUCTURE")
        print("Directed: \(self.directed)")
        print("Vertices number: \(self.vertices)")
        for i in 0..<self.vertices {
            print("====")
            print("Node: \(i) degree: \(self.degree[i])")
            print("Edges: ")
            var edgeNode = self.edges[i]
            while edgeNode != nil {
                print("    d: \(edgeNode!.destinationIndex) w: \(edgeNode!.weight)")
                edgeNode = edgeNode?.nextNode
            }
        }
    }
}
