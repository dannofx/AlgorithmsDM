//
//  Line.swift
//  EraseMe
//
//  Created by Danno on 10/19/17.
//  Copyright © 2017 Daniel Heredia. All rights reserved.
//

import Foundation

let epsilon = 0.00001

func pointInBox(point1: Point, point2: Point, target: Point) -> Bool {
    let (x1, x2) = point1.x > point2.x ? (point2.x, point1.x) : (point1.x, point2.x)
    let (y1, y2) = point1.y > point2.y ? (point2.y, point1.y) : (point1.y, point2.y)
    return target.x >= x1 && target.x <= x2 && target.y >= y1 && target.y <= y2
}

func signedTriangleArea(pointA: Point, pointB: Point, pointC: Point) -> Double{
    return ( pointA.x * pointB.y - pointA.y * pointB.x
            + pointA.y * pointC.x - pointA.x * pointC.y
            + pointB.x * pointC.y - pointC.x * pointB.y) / 2.0
}

func triangleArea(pointA: Point, pointB: Point, pointC: Point) -> Double{
    return abs(signedTriangleArea(pointA: pointA, pointB: pointB, pointC: pointC))
}

func ccw(pointA: Point, pointB: Point, pointC: Point) -> Bool {
    return signedTriangleArea(pointA: pointA, pointB: pointB, pointC: pointC) > epsilon
}

func cw(pointA: Point, pointB: Point, pointC: Point) -> Bool {
    return signedTriangleArea(pointA: pointA, pointB: pointB, pointC: pointC) < epsilon
}

func collinear(pointA: Point, pointB: Point, pointC: Point) -> Bool {
    return abs(signedTriangleArea(pointA: pointA, pointB: pointB, pointC: pointC)) <= epsilon
}

struct Point {
    var x: Double
    var y: Double
    
    func distance(to point: Point) -> Double{
        return sqrt(( pow((point.x - self.x), 2.0) + pow((point.y - self.y), 2.0) ))
    }
    
    func isSamePoint(_ point: Point) -> Bool {
        return abs(self.x - point.x) < epsilon && abs(self.y - point.y) < epsilon 
    }
}

struct Segment {
    var p1: Point
    var p2: Point
    
    func intersectsSegment(segment: Segment) -> Bool {
        let line1 = Line(point1: self.p1, point2: self.p2)
        let line2 = Line(point1: segment.p1, point2: segment.p2)
        if line1.isSameLine(line2) {
            return pointInBox(point1: self.p1, point2: self.p2, target: segment.p1) ||
                   pointInBox(point1: self.p1, point2: self.p2, target: segment.p2) ||
                   pointInBox(point1: segment.p1, point2: segment.p2, target: self.p1) ||
                   pointInBox(point1: segment.p1, point2: segment.p2, target: self.p2)
        }
        
        if line1.isParallel(line: line2) {
            return  false
        }
        
        let intersection = line1.findIntersection(line: line2)!
        return pointInBox(point1: intersection, point2: self.p1, target: self.p2) &&
               pointInBox(point1: intersection, point2: segment.p1, target: segment.p2)
    }
}

struct Line {
    var a: Double // X coefficcient
    var b: Double // Y coefficcient
    var c: Double // Constant term
    
    init(point1: Point, point2: Point) {
        if point1.x == point2.x {
            self.a = 1
            self.b = 0
            self.c = -point1.x
        } else {
            self.b = 1
            self.a = -(point1.y - point2.y) / (point1.x - point2.x)
            self.c = -(self.a * point1.x) - (self.b * point1.x)
        }
    }
    
    init(slope: Double, point: Point) {
        self.a = -slope
        self.b = 1
        self.c = -(self.a * point.x) - (self.b * point.x)
    }
    
    func isParallel(line: Line) -> Bool {
        return abs(self.a - line.a) <= epsilon && abs(self.b - line.b) <= epsilon
    }
    
    func isSameLine(_ line: Line) -> Bool {
        return self.isParallel(line: line) && abs(self.c - line.c) <= epsilon
    }
    
    func findIntersection(line: Line) -> Point? {
        if self.isSameLine(line) {
            print("Warning: Identical lines, all points intersect.")
            return Point(x: 0.0, y: 0.0)
        }
        if self.isParallel(line: line) {
            print("Error: Distinct parallel lines do not intersect.")
            return nil
        }
        let x: Double = (line.b * self.c - self.b * line.c) / (line.a * self.b - self.a * line.b)
        var y: Double!
        if abs(self.b) > epsilon {
            y = -(self.a * x + self.c) / self.b
        } else {
            y = -(line.a * x + line.c) / line.b
        }
        return Point(x: x, y: y)
    }
    
    func findClosestPoint(toPoint point: Point) -> Point {
        var result = Point(x:0.0, y:0.0)
        if abs(self.b) <= epsilon {
            result.x = -self.c
            result.y = point.y
        } else if abs(self.a) <= epsilon {
            result.y = -self.c
            result.x = point.x
        } else {
            let line = Line(slope: (1.0 / self.a), point: point)
            result = self.findIntersection(line: line)!
        }
        return result
    }
}

struct Circle {
    let radius: Double
    let center: Point
    
    func findClosestDistanceToSegment(_ p1: Point, _ p2: Point) -> Double? {
        let line = Line(point1: p1, point2: p2)
        let closestPoint = line.findClosestPoint(toPoint: self.center)
        let inBox = pointInBox(point1: p1, point2: p2, target: closestPoint)
        if inBox {
             return closestPoint.distance(to: self.center)
        } else {
            return nil
        }
    }
    
    func intersectsSegment(_ p1: Point, _ p2: Point) -> Bool {
        if let distance = self.findClosestDistanceToSegment(p1, p2) {
            return distance < self.radius
        } else {
            return false
        }        
    }
}

struct Triangle {
    let points: [Point]
    init(p1: Point, p2: Point, p3: Point) {
        points = [p1, p2, p3]
    }
    
    static func convertToTriangle(points: [Point]) -> Triangle? {
        if points.count != 3 {
            return nil
        } else {
            return Triangle(p1: points[0], p2: points[1], p3: points[2])
        }
    }
    
    var p1: Point {
        return points[0]
    }
    
    var p2: Point {
        return points[1]
    }
    
    var p3: Point {
        return points[2]
    }
    
    func containsPoint(_ point: Point) -> Bool {
        for i in 0..<points.count {
            if cw(pointA: self.points[i], pointB: self.points[i % 3], pointC: point) {
                return false
            }
        }
        return true
    }
}

struct Triangulation {
    var triangleVertices = [(Int, Int, Int)]()
    var size: Int {
        return triangleVertices.count
    }
    
    mutating func addTriangleVertices(i1: Int, i2: Int, i3: Int) {
        self.triangleVertices.append((i1, i2, i3))
    }
}

struct Polygon {
    let points: [Point]
    
    func triangleIsAnEar(indexP1: Int, indexP2: Int, indexP3: Int) -> Bool {
        let triangle = Triangle(p1: self.points[indexP1],
                                p2: self.points[indexP2],
                                p3: self.points[indexP3])
        if cw(pointA: triangle.p1, pointB: triangle.p2, pointC: triangle.p3) {
            return false
        }
        for i in 0..<self.points.count {
            if ( i != indexP1 && i != indexP2 && i != indexP3 ) {
                let point = self.points[i]
                if triangle.containsPoint(point) {
                    return false
                }
            }
        }
        return true
    }
    
    func triangulate() -> Triangulation {
        var triangulation = Triangulation()
        var leftIndices = [Int](repeating: 0, count: self.points.count)
        var rightIndices = [Int](repeating: 0, count: self.points.count)
        for i in 0..<self.points.count {
            let l = ( i - 1 + self.points.count ) % self.points.count
            leftIndices[i] = l
            let r = ( i + 1 + self.points.count ) % self.points.count
            rightIndices[i] = r
        }
        var i = self.points.count - 1
        while triangulation.size < (self.points.count - 2) {
            i = rightIndices[i]
            if self.triangleIsAnEar(indexP1: leftIndices[i], indexP2: i, indexP3: rightIndices[i]) {
                triangulation.addTriangleVertices(i1: leftIndices[i], i2: i, i3: rightIndices[i])
                leftIndices[rightIndices[i]] = leftIndices[i]
                rightIndices[leftIndices[i]] = rightIndices[i]
            }
        }
        return triangulation
    }
    
    func area() -> Double {
        var area = 0.0
        for i in 0..<self.points.count {
            let j = ( i + 1) % self.points.count
            area += (self.points[i].x * self.points[j].y) - (self.points[j].x * self.points[i].y)
        }
        return area / 2.0
    }
}

