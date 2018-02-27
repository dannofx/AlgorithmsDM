// Chapter 6, Challenge 6-1, Freckles

// 10.5.1 Freckles

import Foundation

class Edge {
    let origin: Int
    let destiny: Int
    let weight: Double
    var next: Edge?
    
    init(origin: Int, destiny: Int, weight: Double) {
        self.origin = origin
        self.destiny = destiny
        self.weight = weight
    }
}

var input: [(Double, Double)] = [(1.0, 1.0), (2.0, 2.0), (2.0, 4.0)]
let size = input.count
var edges: [Edge?] =  Array(repeating: nil, count: size)

func addEdge(_ edge: Edge) {
    let existingEdge = edges[edge.origin]
    edge.next = existingEdge
    edges[edge.origin] = edge
}

func generateEdges() {
    for i in 0..<size {
        for j in (i + 1)..<size {
            let p1 = input[i]
            let p2 = input[j]
            let squares = pow(p1.0 - p2.0, 2.0) + pow(p1.1 - p2.1, 2.0)
            let distance = pow(squares, 0.5)
            let edgeA = Edge(origin: i, destiny: j, weight: distance)
            addEdge(edgeA)
            let edgeB = Edge(origin: j, destiny: i, weight: distance)
            addEdge(edgeB)
        }
    }
}

func prim() -> Double {
    let inf = Double.greatestFiniteMagnitude
    var distances = Array(repeating: inf, count: size)
    var intree = Array(repeating: false, count: size)
    var parents = Array(repeating: -1, count: size)
    var vertex = 0
    distances[vertex] = 0
    while intree[vertex] == false {
        intree[vertex] = true
        var edge = edges[vertex]
        while let wEdge = edge {
            if distances[wEdge.destiny] > wEdge.weight && !intree[wEdge.destiny] {
                distances[wEdge.destiny] = wEdge.weight
                parents[wEdge.destiny] = vertex
            }
            edge = wEdge.next
        }
        vertex = 0
        var distance = inf
        for i in 0..<size {
            if !intree[i] && distance > distances[i] {
                distance = distances[i]
                vertex = i
            }
        }
        
    }
    return distances.reduce(0, { $0 + $1 })
}

generateEdges()
let totalDistance = prim()
print("Total distance: \(totalDistance)")

