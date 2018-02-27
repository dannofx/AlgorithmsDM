//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

import Foundation

public class KDTree: NSObject {
    let dimensionsSize: Int
    let dimensionIndex: Int
    let value: [Float]
    var right: KDTree?
    var left: KDTree?
    public init(value: [Float], dimensionIndex: Int) {
        self.value = value
        self.dimensionsSize = value.count
        self.dimensionIndex = dimensionIndex
    }
    
    var isLeaf: Bool {
        return self.right == nil && self.left == nil
    }
    
    func distance(to point: [Float]) -> Float {
        return sqrt(zip(self.value, point).map{ pow(($0 - $1), 2) }.reduce(0.0) { $0 + $1 })
    }
    
    func getSubTree(forPoint point: [Float]) -> KDTree? {
        return point[self.dimensionIndex] > self.value[dimensionIndex] ? self.right : self.left
    }
    func getComplementSubTree(forPoint point: [Float]) -> KDTree? {
        return point[self.dimensionIndex] <= self.value[dimensionIndex] ? self.right : self.left
    }
    
    func dimensionDistance(forPoint point: [Float]) -> Float {
        return abs(point[self.dimensionIndex] - self.value[dimensionIndex])
    }
    
}

func makeTree(fromPoints points:[[Float]], dimensionSize: Int, dimensionIndex: Int = 0) -> KDTree?{
    if points.count == 0 {
        return nil
    }
    let sortedPoints = points.sorted { $0[dimensionIndex] < $1[dimensionIndex] }
    let medianIndex = Int(sortedPoints.count / 2)
    let median = sortedPoints[medianIndex]
    let tree = KDTree.init(value: median, dimensionIndex: dimensionIndex)
    if sortedPoints.count <= 1 {
        return tree
    }
    let newDimensionIndex = (dimensionIndex + 1) % dimensionSize
    tree.left = makeTree(fromPoints: Array(sortedPoints[0..<medianIndex]), dimensionSize: dimensionSize, dimensionIndex: newDimensionIndex)
    tree.right = makeTree(fromPoints: Array(sortedPoints[(medianIndex + 1)..<sortedPoints.count]), dimensionSize: dimensionSize, dimensionIndex: newDimensionIndex)
    return tree
}

func findNearestNeighbor(tree: KDTree, point: [Float], minDistance: Float = Float.infinity, nearestNeighbor: KDTree? = nil) -> (nearest: KDTree, distance: Float) {
    let distance = tree.distance(to: point)
    let currentMinDistance: Float!
    let currentNearestNeighbor: KDTree!
    if distance < minDistance {
        currentMinDistance = distance
        currentNearestNeighbor = tree
    } else {
        currentMinDistance = minDistance
        currentNearestNeighbor = nearestNeighbor
    }
    
    if let subtree = tree.getSubTree(forPoint: point) {
        let newResults = findNearestNeighbor(tree: subtree, point: point, minDistance: currentMinDistance, nearestNeighbor: currentNearestNeighbor)
        let dimensionDistance = tree.dimensionDistance(forPoint: point)
        if newResults.distance > dimensionDistance {
            if let complementSubtree = tree.getComplementSubTree(forPoint: point) {
                return findNearestNeighbor(tree: complementSubtree, point: point, minDistance: newResults.distance, nearestNeighbor: newResults.nearest)
            }
        }
        return newResults
    } else {
        return (currentNearestNeighbor, currentMinDistance)
    }
}

let dimensions = 2
let points: [[Float]] = [[-0.5, 0],
                          [-0.1, -1],
                          [0.0, -1.0],
                          [0.1, 0.5],
                          [1.0, 0.0]]
let targetPoint: [Float] = [-0.1, 0.5]
let tree = makeTree(fromPoints: points, dimensionSize: dimensions)!
let result = findNearestNeighbor(tree: tree, point: targetPoint)
print("Neaest point \(targetPoint): \(result.nearest.value) distance \(result.distance)")

