//
//  ChapterExamples.swift
//  Chapter5
//
//  Created by Danno on 9/6/17.
//  Copyright © 2017 Daniel Heredia. All rights reserved.
//

import Cocoa

func performChapterExamples() {
    findPathExample()
    componentProcessingExample()
    bipartiteExample()
    findingCyclesExample()
    findingArticulationVerticesExample()
    topologicalSortingExample()
    strongComponentsExample()
}

// MARK: - Finding path with BFS

func findPath(graphSearch: GraphSearch, start: Int, end: Int) {
    if start == end || end == -1 {
        print("\(start)")
    } else {
        print("\(end)")
        findPath(graphSearch: graphSearch,
                 start: start,
                 end: graphSearch.parents[end])
    }
}
func findPathExample() {
    var graph = Graph.init(vertices: 6, directed: false)
    graph.addEdge(origin: 0, destination: 1)
    graph.addEdge(origin: 0, destination: 3)
    graph.addEdge(origin: 1, destination: 2)
    graph.addEdge(origin: 2, destination: 4)
    graph.addEdge(origin: 4, destination: 3)
    graph.addEdge(origin: 3, destination: 5)

    let bfs = BreadthFirstSearch.init(graph: graph)
    bfs.performSearch(fromIndex: 0)
    let pathStart = 1
    let pathEnd = 4
    print("Path from \(pathStart) to \(pathEnd)")
    findPath(graphSearch: bfs, start: pathStart, end: pathEnd)
}

// MARK: - Components processing

class ComponentsProcessing: GraphSearchProcessingDelegate {
    func graphSearch(graphSearch: GraphSearch, didProcessEdge edge: (origin: Int, destination: Int)) {
        //print("Processing edge \(edge)")
    }
    
    func graphSearch(graphSearch: GraphSearch, didProcessVertexEarly vertex: Int) {
        print("Component vertex \(vertex)")
    }
    
    func graphSearch(graphSearch: GraphSearch, didProcessVertexLate vertex: Int) {
        // print("Late vertex processing \(vertex)")
    }
}
func componentProcessingExample() {
    var graph = Graph.init(vertices: 11, directed: false)
    graph.addEdge(origin: 0, destination: 1)
    graph.addEdge(origin: 0, destination: 3)
    graph.addEdge(origin: 1, destination: 2)
    graph.addEdge(origin: 2, destination: 4)
    graph.addEdge(origin: 4, destination: 3)
    graph.addEdge(origin: 3, destination: 5)
    graph.addEdge(origin: 6, destination: 7)
    graph.addEdge(origin: 7, destination: 8)
    graph.addEdge(origin: 8, destination: 6)
    graph.addEdge(origin: 9, destination: 10)
    print("Find graph components")
    let bfs = BreadthFirstSearch.init(graph: graph)
    let componentProcessing = ComponentsProcessing()
    bfs.delegate = componentProcessing
    var component = 0
    for i in 0..<bfs.graph.vertices {
        if !bfs.processed[i] {
            print("Component \(component)")
            bfs.performSearch(fromIndex: i)
            component += 1
        }
    }
}

// MARK: - Bipartite graph example

enum Color {
    case noColor
    case white
    case black
    
    func complement() -> Color {
        if self == .white {
            return .black
        } else {
            return .white
        }
    }
}

class BipartiteProcessing: GraphSearchProcessingDelegate {
    var colors: [Color]!
    var bipartite: Bool = true
    
    func graphSearch(graphSearch: GraphSearch, didProcessEdge edge: (origin: Int, destination: Int)) {
        if colors[edge.origin] == colors[edge.destination] {
            print("NO BIPARTITE due to edge \(edge)")
            bipartite = false
        } else {
            colors[edge.destination] = colors[edge.origin].complement()
        }
    }
    
    func graphSearch(graphSearch: GraphSearch, didProcessVertexEarly vertex: Int) {
    }
    
    func graphSearch(graphSearch: GraphSearch, didProcessVertexLate vertex: Int) {
    }
}

func checkIfBipartite(graphSearch: GraphSearch) {
    let bipartiteProcessing = (graphSearch.delegate as! BipartiteProcessing)
    for i in 0..<graphSearch.graph.vertices {
        if !graphSearch.discovered[i] {
            bipartiteProcessing.colors[i] = .white
            graphSearch.performSearch(fromIndex: i)
        }
    }
    print("Bipartite: \(bipartiteProcessing.bipartite)")
}

func bipartiteExample() {
    var graph = Graph.init(vertices: 4, directed: false)
    graph.addEdge(origin: 0, destination: 1)
    graph.addEdge(origin: 1, destination: 2)
    graph.addEdge(origin: 2, destination: 3)
    graph.addEdge(origin: 3, destination: 0)
    print("Find wheter bipartite or not")
    let bfs = BreadthFirstSearch.init(graph: graph)
    let bipartiteProcessing = BipartiteProcessing()
    bipartiteProcessing.colors = [Color].init(repeating: .noColor, count: graph.vertices)
    bfs.delegate = bipartiteProcessing
    checkIfBipartite(graphSearch: bfs)
}

// MARK: - Finding cycles with DFS
class CycleProcessing: GraphSearchProcessingDelegate {
    var cycleFound = false
    func graphSearch(graphSearch: GraphSearch, didProcessEdge edge: (origin: Int, destination: Int)) {
        if graphSearch.parents[edge.destination] != edge.origin &&
            graphSearch.parents[edge.origin] != edge.destination {
            graphSearch.finished = true
            print("Cycle found from \(edge.origin) to \(edge.destination)")
            self.cycleFound = true
        }
    }
    
    func graphSearch(graphSearch: GraphSearch, didProcessVertexEarly vertex: Int) {
    }
    
    func graphSearch(graphSearch: GraphSearch, didProcessVertexLate vertex: Int) {
    }
}
func findingCyclesExample() {
    var graph = Graph.init(vertices: 4, directed: false)
    graph.addEdge(origin: 0, destination: 1)
    graph.addEdge(origin: 1, destination: 2)
    graph.addEdge(origin: 2, destination: 3)
    graph.addEdge(origin: 3, destination: 0)
    let dfs = DepthFirstSearch(graph: graph)
    print("Finding cycles in graph")
    let cyclesProcessing = CycleProcessing.init()
    dfs.delegate = cyclesProcessing
    dfs.performSearch(fromIndex: 0)
    print("Cycle found: \(cyclesProcessing.cycleFound)")
}

// MARK: - Finding articulation vertices with DFS

class ArticulationVerticesProcessing: GraphSearchProcessingDelegate {
    var reachableAncestor: [Int]!
    var treeOutdegree: [Int]!
    
    func initialize(forSize size: Int) {
        self.reachableAncestor = [Int].init(repeating: -1, count: size)
        self.treeOutdegree = [Int].init(repeating: -1, count: size)
    }
    
    func graphSearch(graphSearch: GraphSearch, didProcessVertexEarly vertex: Int) {
        self.reachableAncestor[vertex] = vertex
    }
    
    func graphSearch(graphSearch: GraphSearch, didProcessEdge edge: (origin: Int, destination: Int)) {
        let dfs = graphSearch as! DepthFirstSearch
        let classification = self.edgeClassification(search: dfs, edge: edge)
        if classification == .tree {
            self.treeOutdegree[edge.origin] = self.treeOutdegree[edge.origin] + 1
        }
        if classification == .back && dfs.parents[edge.origin] != edge.destination {
            if dfs.entryTimes[edge.destination] < dfs.entryTimes[self.reachableAncestor[edge.origin]] {
                self.reachableAncestor[edge.origin] = edge.destination
            }
        }
    }
    
    
    func graphSearch(graphSearch: GraphSearch, didProcessVertexLate vertex: Int) {
        let dfs = graphSearch as! DepthFirstSearch
        if dfs.parents[vertex] < 0 {
            if self.treeOutdegree[vertex] > 1 {
                print("Root articulation vertex: \(vertex)")
            }
            return
        }
        let rootParent = dfs.parents[dfs.parents[vertex]] < 0
        if self.reachableAncestor[vertex] == dfs.parents[vertex] && !rootParent {
            print("Parent articulation vertex: \(dfs.parents[vertex])")
        }
        if self.reachableAncestor[vertex] == vertex {
            print("Bridge articulation vertex: \(dfs.parents[vertex])")
            if self.treeOutdegree[vertex] > 0 {
                print("Bridge articulation vertex: \(vertex)")
            }
        }
        let timeVertex = dfs.entryTimes[self.reachableAncestor[vertex]]
        let timeParent = dfs.entryTimes[self.reachableAncestor[dfs.parents[vertex]]]
        if timeVertex < timeParent {
            self.reachableAncestor[dfs.parents[vertex]] = self.reachableAncestor[vertex]
        }
    }
}
func findingArticulationVerticesExample() {
    var graph = Graph.init(vertices: 10, directed: false)
    graph.addEdge(origin: 0, destination: 1)
    graph.addEdge(origin: 0, destination: 2)
    graph.addEdge(origin: 1, destination: 3)
    graph.addEdge(origin: 2, destination: 3)
    graph.addEdge(origin: 3, destination: 4)
    graph.addEdge(origin: 3, destination: 5)
    graph.addEdge(origin: 4, destination: 6)
    graph.addEdge(origin: 5, destination: 6)
    graph.addEdge(origin: 0, destination: 7)
    graph.addEdge(origin: 7, destination: 8)
    graph.addEdge(origin: 8, destination: 9)
    print("Finding articulation vertices")
    let artProcessing = ArticulationVerticesProcessing()
    artProcessing.initialize(forSize: graph.vertices)
    let dfs = DepthFirstSearch(graph: graph)
    dfs.delegate = artProcessing
    dfs.performSearch(fromIndex: 0)
}

// MARK: - Topological sorting on a Directed Acyclic Graph (DAG)
class TopologicalSortProcessing: GraphSearchProcessingDelegate {
    var path: [Int] = []
    
    func graphSearch(graphSearch: GraphSearch, didProcessVertexEarly vertex: Int) {
    }
    
    func graphSearch(graphSearch: GraphSearch, didProcessEdge edge: (origin: Int, destination: Int)) {
        let classification = self.edgeClassification(search: graphSearch, edge: edge)
        if classification == .back {
            print("Warning: directed cycle found, not a DAG")
        }
    }
    
    
    func graphSearch(graphSearch: GraphSearch, didProcessVertexLate vertex: Int) {
        self.path.append(vertex)
    }
}
func topologicalSortingExample() {
    var directedGraph = Graph.init(vertices: 7, directed: true)
    directedGraph.addEdge(origin: 0, destination: 1)
    directedGraph.addEdge(origin: 1, destination: 2)
    directedGraph.addEdge(origin: 2, destination: 5)
    directedGraph.addEdge(origin: 5, destination: 4)
    directedGraph.addEdge(origin: 4, destination: 3)
    directedGraph.addEdge(origin: 6, destination: 0)
    print("Finding topological sort")
    let topProcessing = TopologicalSortProcessing()
    let dfs = DepthFirstSearch(graph: directedGraph)
    dfs.delegate = topProcessing
    for i in 0..<dfs.processed.count {
        if !dfs.processed[i] {
            dfs.performSearch(fromIndex: i)
        }
    }
    for i in 0..<topProcessing.path.count {
        print("i: \(i), vertex: \(topProcessing.path.removeLast())")
    }
}

// MARK: - Strong components example
class StrongComponentsProcessing: GraphSearchProcessingDelegate {
    
    var low: [Int]!
    var scc: [Int]!
    var active: [Int]!
    var componentsFound = 0
    
    func initialize(forSize size: Int) {
        self.low = Array(0..<size)
        self.scc = [Int].init(repeating: -1, count: size)
        self.active = [Int]()
        self.componentsFound = 0
    }
    
    func graphSearch(graphSearch: GraphSearch, didProcessVertexEarly vertex: Int) {
        self.active.append(vertex)
    }
    
    func graphSearch(graphSearch: GraphSearch, didProcessEdge edge: (origin: Int, destination: Int)) {
        let dfs = graphSearch as! DepthFirstSearch
        let classification = self.edgeClassification(search: graphSearch, edge: edge)
        if classification == .back {
            if dfs.entryTimes[edge.destination] < dfs.entryTimes[edge.origin] {
                self.low[edge.origin] = edge.destination
            }
        } else if classification == .cross {
            if self.scc[edge.destination] == -1 {
                if dfs.entryTimes[edge.destination] < dfs.entryTimes[edge.origin] {
                    self.low[edge.origin] = edge.destination
                }
            }
        }
    }
    
    func graphSearch(graphSearch: GraphSearch, didProcessVertexLate vertex: Int) {
        let dfs = graphSearch as! DepthFirstSearch
        if self.low[vertex] == vertex {
            self.popComponent(vertex: vertex)
        }
        let parent = dfs.parents[vertex]
        if parent >= 0 && dfs.entryTimes[vertex] < dfs.entryTimes[parent] {
            self.low[parent] = self.low[vertex]
        }
    }
    
    func popComponent(vertex: Int) {
        self.componentsFound += 1
        print("== New component: \(componentsFound)")
        print("   v:\(vertex)")
        self.scc[vertex] = self.componentsFound
        var currentVertex = self.active.removeLast()
        while currentVertex != -1 && currentVertex != vertex{
            self.scc[currentVertex] = componentsFound
            print("   v:\(currentVertex)")
            currentVertex = self.active.count > 0 ? self.active.removeLast() : -1
        }
    }
}

func strongComponentsExample() {
    var directedGraph = Graph.init(vertices: 8, directed: true)
    directedGraph.addEdge(origin: 0, destination: 1)
    directedGraph.addEdge(origin: 0, destination: 2)
    directedGraph.addEdge(origin: 0, destination: 3)
    directedGraph.addEdge(origin: 1, destination: 0)
    directedGraph.addEdge(origin: 1, destination: 2)
    directedGraph.addEdge(origin: 1, destination: 3)
    directedGraph.addEdge(origin: 2, destination: 0)
    directedGraph.addEdge(origin: 2, destination: 1)
    directedGraph.addEdge(origin: 2, destination: 3)
    directedGraph.addEdge(origin: 3, destination: 0)
    directedGraph.addEdge(origin: 3, destination: 1)
    directedGraph.addEdge(origin: 3, destination: 2)

    directedGraph.addEdge(origin: 4, destination: 5)
    directedGraph.addEdge(origin: 4, destination: 6)
    directedGraph.addEdge(origin: 5, destination: 4)
    directedGraph.addEdge(origin: 5, destination: 6)
    directedGraph.addEdge(origin: 6, destination: 4)
    directedGraph.addEdge(origin: 6, destination: 5)

    directedGraph.addEdge(origin: 3, destination: 7)
    directedGraph.addEdge(origin: 3, destination: 5)
    directedGraph.addEdge(origin: 7, destination: 5)
    directedGraph.addEdge(origin: 1, destination: 4)

    print("Discovering strong components")

    let stronProcessing = StrongComponentsProcessing()
    let dfs = DepthFirstSearch(graph: directedGraph)
    stronProcessing.initialize(forSize: directedGraph.vertices)
    dfs.delegate = stronProcessing

    for i in 0..<directedGraph.vertices {
        if !dfs.discovered[i] {
            dfs.performSearch(fromIndex: i)
        }
    }
}
