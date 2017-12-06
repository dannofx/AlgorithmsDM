//
//  Line.swift
//  Geometry
//
//  Created by Danno on 10/19/17.
//  Copyright © 2017 Daniel Heredia. All rights reserved.
//

import Foundation

// Error range
let epsilon = 0.00001
// Operators to manage error range
infix operator <<=: AdditionPrecedence
infix operator >>=: AdditionPrecedence
infix operator ====: AdditionPrecedence
infix operator !===: AdditionPrecedence

// MARK: Point structure

struct Point {
    var x: Double
    var y: Double
    
    func distance(to point: Point) -> Double{
        return sqrt(( pow((point.x - self.x), 2.0) + pow((point.y - self.y), 2.0) ))
    }
    
    func isSamePoint(_ point: Point) -> Bool {
        return self.x ==== point.x && self.y ==== point.y
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
        return pointInBox(point1: self.p1, point2: self.p2, target: intersection) &&
            pointInBox(point1: segment.p1, point2: segment.p2, target: intersection)
    }
    
//    Alternative implementation using determinants
//    func intersectsSegment(segment: Segment) -> Bool {
//        let localOrientation1 = orientation(pointA: self.p1, pointB: self.p2, pointC: segment.p1)
//        let localOrientation2 = orientation(pointA: self.p1, pointB: self.p2, pointC: segment.p2)
//        let segmentOrientation1 = orientation(pointA: segment.p1, pointB: segment.p2, pointC: self.p1)
//        let segmentOrientation2 = orientation(pointA: segment.p1, pointB: segment.p2, pointC: self.p2)
//
//        // General situation
//        if (localOrientation1 != localOrientation2 &&
//            segmentOrientation1 != segmentOrientation2) {
//            return true
//        }
//        //Special cases for collinear segments
//        // Local segment collinear with point 1 of the parameter segment
//        if localOrientation1 == .collinear && self.liesOnSegment(point: segment.p1) {
//            return true
//        }
//        // Local segment collinear with point 2 of the parameter segment
//        if localOrientation2 == .collinear && self.liesOnSegment(point: segment.p2) {
//            return true
//        }
//        // Parameter segment collinear with point 1 of the local segment
//        if segmentOrientation1 == .collinear && segment.liesOnSegment(point: self.p1) {
//            return true
//        }
//        // Parameter segment collinear with point 2 of the local segment
//        if segmentOrientation2 == .collinear && segment.liesOnSegment(point: self.p2) {
//            return true
//        }
//        return false
//    }
    
    var line: Line {
        return Line(point1: p1, point2: p2)
    }
    
    func liesOnSegment(point: Point) -> Bool {
        if self.line.liesOnLine(point: point) {
            return pointInBox(point1: self.p1, point2: self.p2, target: point)
        } else {
            return false
        }
    }
    
//    Alternative implementation using determinants
//    func liesOnSegment(point: Point) -> Bool {
//        if collinear(pointA: self.p1, pointB: self.p2, pointC: point) {
//            return pointInBox(point1: self.p1, point2: self.p2, target: point)
//        } else {
//            return false
//        }
//    }
    
}

// MARK: Line structure

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
            self.c = -(self.a * point1.x) - (self.b * point1.y)
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
    
    func liesOnLine(point: Point) -> Bool {
        if abs(self.b) <= epsilon {
            return abs(point.x + self.c) < epsilon
        } else if abs(self.a) <= epsilon {
            return abs(point.y + self.c) < epsilon
        } else {
            let sum = self.a * point.x + self.b * point.y + self.c
            return abs(sum) < epsilon
        }
    }
}

// MARK: Circle structure

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

// MARK: Triangle structure

struct Triangle {
    let points: [Point]
    init(point1: Point, point2: Point, point3: Point) {
        points = [point1, point2, point3]
    }
    
    static func convertToTriangle(points: [Point]) -> Triangle? {
        if points.count != 3 {
            return nil
        } else {
            return Triangle(point1: points[0], point2: points[1], point3: points[2])
        }
    }
    
    var point1: Point {
        return points[0]
    }
    
    var point2: Point {
        return points[1]
    }
    
    var point3: Point {
        return points[2]
    }
    
    static func signedArea(pointA: Point, pointB: Point, pointC: Point) -> Double{
        return ( pointA.x * pointB.y - pointA.y * pointB.x
            + pointA.y * pointC.x - pointA.x * pointC.y
            + pointB.x * pointC.y - pointC.x * pointB.y) / 2.0
    }
    
    static func area(pointA: Point, pointB: Point, pointC: Point) -> Double{
        return abs(self.signedArea(pointA: pointA, pointB: pointB, pointC: pointC))
    }
    
    func signedArea() -> Double {
        return Triangle.area(pointA: self.point1, pointB: self.point2, pointC: self.point3)
    }
    
    func area() -> Double {
        return Triangle.area(pointA: self.point1, pointB: self.point2, pointC: self.point3)
    }
    
    func containsPoint(_ point: Point) -> Bool {
        for i in 0..<points.count {
            if ccw(pointA: self.points[i], pointB: self.points[(i + 1) % 3], pointC: point) {
                return false
            }
        }
        return true
    }
}

// MARK: Polygon structure

struct Polygon {
    
    enum PolygonError: Error {
        case triangulationConversion(String)
    }

    let points: [Point]
    private func triangleIsAnEar(indexP1: Int, indexP2: Int, indexP3: Int) -> Bool {
        let triangle = Triangle(point1: self.points[indexP1],
                                point2: self.points[indexP2],
                                point3: self.points[indexP3])
        if !cw(pointA: triangle.point1, pointB: triangle.point2, pointC: triangle.point3) {
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
    
    func triangulate() -> [(vertexIndexA: Int, vertexIndexB: Int, vertexIndexC: Int)] {
        var trianglesVertices = [(Int, Int, Int)]()
        var leftIndices = [Int](repeating: 0, count: self.points.count)
        var rightIndices = [Int](repeating: 0, count: self.points.count)
        for i in 0..<self.points.count {
            let l = ( i - 1 + self.points.count ) % self.points.count
            leftIndices[i] = l
            let r = ( i + 1 + self.points.count ) % self.points.count
            rightIndices[i] = r
        }

        var i = self.points.count - 1
        while trianglesVertices.count != (self.points.count - 2) {
            i = rightIndices[i]
            if self.triangleIsAnEar(indexP1: leftIndices[i], indexP2: i, indexP3: rightIndices[i]) {
                trianglesVertices.append((leftIndices[i], i, rightIndices[i]))
                leftIndices[rightIndices[i]] = leftIndices[i]
                rightIndices[leftIndices[i]] = rightIndices[i]
            }
        }
        return trianglesVertices
    }
    
    func convertTriangulation(_ triangulation: [(Int, Int, Int)]) throws -> [Triangle] {
        var triangles = [Triangle]()
        for triangleVertices in triangulation {
            if triangleVertices.0 < 0 || triangleVertices.0 >= self.points.count ||
                triangleVertices.1 < 0 || triangleVertices.1 >= self.points.count ||
                triangleVertices.2 < 0 || triangleVertices.2 >= self.points.count {
                throw PolygonError.triangulationConversion("The triangulation indices doesn't coincide with the polygon points")
            }
            triangles.append(Triangle(point1: self.points[triangleVertices.0],
                                      point2: self.points[triangleVertices.1],
                                      point3: self.points[triangleVertices.2]))
        }
        return triangles
    }
    
    func area() -> Double {
        var area = 0.0
        for i in 0..<self.points.count {
            let j = ( i + 1 ) % self.points.count
            area += (self.points[i].x * self.points[j].y) - (self.points[j].x * self.points[i].y)
        }
        return abs(area / 2.0)
    }
}

// MARK: Comparisons handling margin error

public extension Double {
    static func <<=(lhs: Double, rhs: Double) -> Bool {
        if abs(lhs - rhs) < epsilon {
            return true
        } else {
            return lhs < rhs
        }
    }
    
    static func >>=(lhs: Double, rhs: Double) -> Bool {
        if abs(lhs - rhs) < epsilon {
            return true
        } else {
            return lhs > rhs
        }
    }
    
    static func ====(lhs: Double, rhs: Double) -> Bool {
        return abs(lhs - rhs) < epsilon
    }
    
    static func !===(lhs: Double, rhs: Double) -> Bool {
        return abs(lhs - rhs) > epsilon
    }
}

// MARK: Some util methods

// Checks if a point is contained in the rectangle formed by another 2 points
func pointInBox(point1: Point, point2: Point, target: Point) -> Bool {
    let (x1, x2) = point1.x > point2.x ? (point2.x, point1.x) : (point1.x, point2.x)
    let (y1, y2) = point1.y > point2.y ? (point2.y, point1.y) : (point1.y, point2.y)
    return target.x >>= x1 && target.x <<= x2 && target.y >>= y1 && target.y <<= y2
}

//escribir operadores >>= y <<=, para tomar en cuenta el epsilon, serian un > y un < respectivamente,
//pero antes checando si es igual por medio de abs(diff) < epsilon

// Determines if the orientation of 3 ordered points is clockwise
func cw(pointA: Point, pointB: Point, pointC: Point) -> Bool {
    return Triangle.signedArea(pointA: pointA, pointB: pointB, pointC: pointC) < ( epsilon * -1 )
}
// Determines if the orientation of 3 ordered points is counter clockwise
func ccw(pointA: Point, pointB: Point, pointC: Point) -> Bool {
    return Triangle.signedArea(pointA: pointA, pointB: pointB, pointC: pointC) > epsilon
}

// Determines if the orientation of 3 ordered points are collinear
func collinear(pointA: Point, pointB: Point, pointC: Point) -> Bool {
    return abs(Triangle.signedArea(pointA: pointA, pointB: pointB, pointC: pointC)) <= epsilon
}

enum PointOrientation: Int{
    case collinear = 0
    case cw = 1
    case ccw = -1
}

/// Determines the orientation of the point C based in the segment A-B
///
/// - Parameters:
///   - pointA: First point of the segment
///   - pointB: Second point of the segment
///   - pointC: Point to evaluate
/// - Returns: Triangle orientation value
func orientation(pointA: Point, pointB: Point, pointC: Point) -> PointOrientation {
    let signedArea = Triangle.signedArea(pointA: pointA, pointB: pointB, pointC: pointC)
    if signedArea ==== 0.0 {
        return .collinear
    } else if signedArea > 0.0 {
        return .cw
    } else {
        return .ccw
    }
}





