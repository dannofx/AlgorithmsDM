//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

//
//  ConvexHull.swift
//  Geometry
//
//  Created by Danno on 10/26/17.
//  Copyright © 2017 Daniel Heredia. All rights reserved.
//

import Cocoa

// MARK: Extension that generates a convex hull polygon from a polygon

extension Polygon {
    
    static func createConvexHullPolygon(withPoints points: [Point]) -> Polygon {
        if points.count <= 3 {
            let polygon = Polygon(points: points)
            return polygon
        }
        var polygonPoints = [Point]()
        var sortedPoints = sortAndRemoveDuplicates(points: points)
        polygonPoints.append(sortedPoints.first!)
        sortedPoints.removeFirst()
        sortedPoints.sort { (point1, point2) -> Bool in
            return self.areSortedByAngle(reference: polygonPoints.first!, point1: point1, point2: point2)
        }
        sortedPoints.insert(polygonPoints.first!, at: 0)
        polygonPoints.append(sortedPoints[1])
        sortedPoints.append(polygonPoints.first!)
        var top = 1
        var i = 2
        while i < sortedPoints.count {
            if cw(pointA: polygonPoints[top - 1], pointB: polygonPoints[top], pointC: sortedPoints[i]) {
                top = top + 1
                if top >= polygonPoints.count {
                    polygonPoints.append(sortedPoints[i])
                } else {
                    polygonPoints[top] = sortedPoints[i]
                }
                i = i + 1
            } else {
                top = top - 1
            }
        }
        polygonPoints = Array(polygonPoints.dropLast(polygonPoints.count - top))
        return Polygon(points: polygonPoints)
    }
    
    func extractConvexHull() -> Polygon {
        return Polygon.createConvexHullPolygon(withPoints: self.points)
    }
}

// MARK: Convex hull utils (used just by convex hull extension)

fileprivate extension Polygon {
    
    static func isLeftPointLower(left: Point, right: Point) -> Bool {
        if left.x < right.x {
            return true
        }
        if left.x > right.x {
            return false
        }
        if left.y < right.y {
            return true
        }
        if left.y > right.y {
            return false
        }
        return false
    }
    
    static func sortAndRemoveDuplicates(points: [Point]) -> [Point] {
        var sortedPoints = points.sorted { (p1, p2) -> Bool in
            return self.isLeftPointLower(left: p1, right: p2)
        }
        var newn = sortedPoints.count
        var hole = 1
        for i in 1..<sortedPoints.count { //i in 1..<(sortedPoints.count - 1)
            let pointI = sortedPoints[i]
            let pointH = sortedPoints[hole - 1]
            if pointI.isSamePoint(pointH) {
                newn -= 1
            } else {
                sortedPoints[hole] = sortedPoints[i]
                hole += 1
            }
        }
        sortedPoints = Array(sortedPoints.dropLast(sortedPoints.count - newn))
        //sortedPoints[hole] = sortedPoints[sortedPoints.count - 1] PORQUE SE TRATA AFUERA?!!!
        return sortedPoints
    }
    
    static func areSortedByAngle(reference: Point, point1: Point, point2: Point) -> Bool {
        if collinear(pointA: reference, pointB: point1, pointC: point2) {
            return reference.distance(to: point1) <= reference.distance(to: point2)
        } else {
            return cw(pointA: reference, pointB: point1, pointC: point2)
        }
    }
}
