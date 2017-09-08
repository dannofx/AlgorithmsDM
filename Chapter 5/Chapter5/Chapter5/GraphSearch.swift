//
//  GraphSearch.swift
//  Chapter5
//
//  Created by Danno on 9/6/17.
//  Copyright © 2017 Daniel Heredia. All rights reserved.
//

import Cocoa

// MARK: - Search base structure (search and result processing templates)

protocol GraphSearchProcessingDelegate: class {
    func graphSearch(graphSearch: GraphSearch, didProcessVertexEarly vertex: Int)
    func graphSearch(graphSearch: GraphSearch, didProcessEdge edge:(origin: Int, destination: Int))
    func graphSearch(graphSearch: GraphSearch, didProcessVertexLate vertex: Int)
}

class GraphSearch {
    let graph: Graph
    var processed: [Bool]!
    var discovered: [Bool]!
    var parents: [Int]!
    var finished: Bool = false
    weak var delegate: GraphSearchProcessingDelegate?
    
    init(graph: Graph) {
        self.graph =  graph
        self.resetSearch()
    }
    
    func resetSearch() {
        self.processed = [Bool].init(repeating: false, count: self.graph.vertices)
        self.discovered = [Bool].init(repeating: false, count: self.graph.vertices)
        self.parents = [Int].init(repeating: -1, count: self.graph.vertices)
        self.finished = false
    }
    func performSearch(fromIndex start: Int) {
        fatalError("Subclasses need to implement the `performSearch(fromIndex:)` method.")
    }
}

// MARK: - Breadth First Search implementation

class BreadthFirstSearch: GraphSearch {
    override func performSearch(fromIndex start: Int) {
        if start >= self.graph.vertices || start < 0 {
            print("Error: Search from \(start) is out of range")
        }
        var queue: [Int] = []
        self.discovered[start] = true
        queue.append(start)
        while queue.count > 0 {
            let currentOrigin = queue.removeFirst()
            self.delegate?.graphSearch(graphSearch: self, didProcessVertexEarly: currentOrigin)
            self.processed[currentOrigin] = true
            var currentEdge = self.graph.edges[currentOrigin]
            while currentEdge != nil {
                let currentDestination = currentEdge!.destinationIndex
                if !self.processed[currentDestination] || self.graph.directed {
                    self.delegate?.graphSearch(graphSearch: self, didProcessEdge: (currentOrigin, currentDestination))
                }
                if !self.discovered[currentDestination] {
                    queue.append(currentDestination)
                    self.discovered[currentDestination] = true
                    self.parents[currentDestination] = currentOrigin
                }
                
                currentEdge = currentEdge?.nextNode
            }
            self.delegate?.graphSearch(graphSearch: self, didProcessVertexLate: currentOrigin)
        }
    }
}

// MARK: - Depth First Search implementation

class DepthFirstSearch: GraphSearch {
    
    var entryTimes: [Int]!
    var exitTimes: [Int]!
    var time = 0
    
    override func resetSearch() {
        super.resetSearch()
        self.entryTimes = [Int].init(repeating: 0, count: self.graph.vertices)
        self.exitTimes = [Int].init(repeating: 0, count: self.graph.vertices)
        time = 0
    }
    
    override func performSearch(fromIndex start: Int) {
        if start >= self.graph.vertices || start < 0 {
            print("Error: Search from \(start) is out of range")
        }
        if finished {
            return
        }
        self.discovered[start] = true
        time += 1
        self.entryTimes[start] = time
        self.delegate?.graphSearch(graphSearch: self, didProcessVertexEarly: start)
        var currentEdge = self.graph.edges[start]
        while currentEdge != nil {
            let destination = currentEdge!.destinationIndex
            if !self.discovered[destination] {
                self.parents[destination] = start
                self.delegate?.graphSearch(graphSearch: self, didProcessEdge: (start, destination))
                self.performSearch(fromIndex: destination)
            } else if !self.processed[destination] || self.graph.directed {
                self.delegate?.graphSearch(graphSearch: self, didProcessEdge: (start, destination))
            }
            if finished {
                return
            }
            currentEdge = currentEdge?.nextNode
        }
        self.delegate?.graphSearch(graphSearch: self, didProcessVertexLate: start)
        time += 1
        self.exitTimes[start] = time
        self.processed[start] = true
        
    }
}

// MARK: - Classification utils
enum EdgeClassification {
    case tree
    case back
    case forward
    case cross
    case noClassified
}

extension GraphSearchProcessingDelegate {
    
    func edgeClassification(search: GraphSearch, edge: (origin: Int, destination: Int)) -> EdgeClassification {
        let dfs = search as! DepthFirstSearch
        if dfs.parents[edge.destination] == edge.origin {
            return .tree
        }
        if dfs.discovered[edge.destination] && !dfs.processed[edge.destination] {
            return .back
        }
        if dfs.processed[edge.destination] && dfs.entryTimes[edge.destination] > dfs.entryTimes[edge.origin] {
            return .forward
        }
        if dfs.processed[edge.destination] && dfs.entryTimes[edge.destination] < dfs.entryTimes[edge.origin] {
            return .cross
        }
        print("Warning: Unclassified edge \(edge)")
        return .noClassified
    }
    
}

