//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Intersection

import Foundation

enum IntersectionType {
    case noIntersection
    case sameLine
    case point
}

struct Point {
    let x: Double
    let y: Double
}

struct Line {
    let a: Double
    let b: Double
    let c: Double
    
    init(point1: Point, point2: Point) {
        precondition(point1.x != point2.x || point1.y != point2.y)
        let vx = point2.x - point1.x
        let vy = point2.y - point1.y
        self.a = vy
        self.b = -1 * vx
        self.c = vx * point1.y - vy * point1.x
    }
    
    func isSameLine(line: Line) -> Bool {
        if !self.isParallelLine(line: line) {
            return false
        }
        if self.a == 0.0 || self.b == 0.0 {
            return self.c == line.c
        } else {
            if self.c == 0.0 {
                return line.c == 0.0
            } else {
                let proportionC = line.c / self.c
                let proportionB = line.b / self.b
                return proportionC == proportionB
            }
        }
    }
    
    func isParallelLine(line: Line) -> Bool {
        if self.a == 0.0 {
            return line.a == 0.0
        }
        if self.b == 0.0 {
            return line.b == 0.0
        }
        let proportionA = self.a / line.a
        let proportionB = self.b / line.b
        return proportionA == proportionB
    }
    
    func getIntersection(line: Line) -> (type: IntersectionType, point: Point?) {
        if self.isParallelLine(line: line) {
            if self.isSameLine(line: line) {
                return (.sameLine, nil)
            } else {
                return (.noIntersection, nil)
            }
        }
        var x = 0.0
        var y = 0.0
        let xDivisor = (self.b * line.a - line.b * self.a)
        if xDivisor == 0.0 {
            x = line.b == 0.0 ? line.c / line.a : self.c / self.a
        } else {
            x = (line.b * self.c - self.b * line.c) / xDivisor
        }
        if line.b == 0.0 {
            y = -1 * (self.a * x + self.c) / self.b
        } else {
            y = -1 * (line.a * x + line.c) / line.b
        }
        return (.point, Point(x: x, y: y))
    }
    
    func isOnLine(point: Point) -> Bool {
        return (self.a * point.x + self.b * point.y + self.c) == 0.0
    }
}

struct Segment {
    let point1: Point
    let point2: Point
    let line: Line
    
    init(point1: Point, point2: Point) {
        self.point1 = point1
        self.point2 = point2
        self.line = Line(point1: point1, point2: point2)
    }
    
    private func isInBox(point: Point) -> Bool {
        let maxX = max(self.point1.x, self.point2.x)
        let minX = min(self.point1.x, self.point2.x)
        let maxY = max(self.point1.y, self.point2.y)
        let minY = min(self.point1.y, self.point2.y)
        return point.x >= minX && point.x <= maxX &&
                point.y >= minY && point.y <= maxY
    }
    
    func isOnSegment(point: Point) -> Bool {
        if !self.line.isOnLine(point: point) {
            return false
        }
        return isInBox(point:point)
    }
    
    func getIntersection(segment: Segment) -> Point? {
        let intersection = self.line.getIntersection(line: segment.line)
        guard let point = intersection.point else{
            if self.line.isSameLine(line: segment.line) {
                if self.isInBox(point: segment.point1) {
                    return segment.point1
                } else if self.isInBox(point: segment.point2) {
                    return segment.point2
                }
            }
            return nil
        }
        if self.isInBox(point: point) && segment.isInBox(point: point) {
            return point
        } else {
            return nil
        }
    }
}
let s1Point1 = Point(x: -5.0, y: -5.0)
let s1Point2 = Point(x: 5.0, y: 5.0)
let s2Point1 = Point(x: 2.0, y: 100.0)
let s2Point2 = Point(x: 2.0, y: -100.0)

let segment1 = Segment(point1: s1Point1, point2: s1Point2)
let segment2 = Segment(point1: s2Point1, point2: s2Point2)

if let intersection = segment1.getIntersection(segment: segment2) {
    print("Intersection: (x: \(intersection.x), y: \(intersection.y))")
} else {
    print("No intersection")
}


