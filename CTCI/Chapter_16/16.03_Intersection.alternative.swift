//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Intersection

// Solution using the slop-intercept equation form instead of the standard form

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
    let m: Double
    let b: Double
    let isVertical: Bool
    
    init(point1: Point, point2: Point) {
        precondition(point1.x != point2.x || point1.y != point2.y)
        self.isVertical = (point2.x - point1.x) == 0.0
        if self.isVertical {
            self.m = Double.infinity
            self.b = point1.x
        } else {
            self.m = (point2.y - point1.y) / (point2.x - point1.x)
            self.b = point2.y - self.m * point2.x
        }
    }
    
    func isOnLine(point: Point) -> Bool {
        if self.isVertical {
            return point.x == self.b
        } else {
            return point.y == (self.m * point.x + self.b)
        }
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

    func isOnSegment(point: Point) -> Bool{
        if self.line.isOnLine(point: point) {
            let minX = min(self.point1.x, self.point2.x)
            let maxX = max(self.point1.x, self.point2.x)
            let minY = min(self.point1.y, self.point2.y)
            let maxY = max(self.point1.y, self.point2.y)
            return minX <= point.x && maxX >= point.x &&
                    minY <= point.y && maxY >= point.y
        } else {
            return false
        }
    }
    
    func getIntersection(segment: Segment) -> Point? {
        if self.line.m == segment.line.m {
            if self.line.b == segment.line.b {
                if self.isOnSegment(point: segment.point1) {
                    return segment.point1
                } else if self.isOnSegment(point: segment.point2) {
                    return segment.point2
                }
            }
            return nil
        }
        var x = 0.0
        if self.line.isVertical {
            x = self.line.b
        } else if segment.line.isVertical {
            x = segment.line.b
        } else {
            x = (segment.line.b - self.line.b) / (self.line.m - segment.line.m)
        }

        let testSegment = self.line.isVertical ? segment : self
        let y = testSegment.line.m * x + testSegment.line.b
        let intersection = Point(x: x, y: y)
        return self.isOnSegment(point: intersection) && segment.isOnSegment(point: intersection) ? intersection : nil
    }
}
let s1Point1 = Point(x: 5.0, y: 5.0)
let s1Point2 = Point(x: 10.0, y: 10.0)
let s2Point1 = Point(x: -10.0, y: 10.0)
let s2Point2 = Point(x: 10.0, y: -10.0)

let segment1 = Segment(point1: s1Point1, point2: s1Point2)
let segment2 = Segment(point1: s2Point1, point2: s2Point2)

if let intersection = segment1.getIntersection(segment: segment2) {
    print("Intersection: (x: \(intersection.x), y: \(intersection.y))")
} else {
    print("No intersection")
}
