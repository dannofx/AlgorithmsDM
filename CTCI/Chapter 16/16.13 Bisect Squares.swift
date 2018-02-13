// Bisect Squares

import Foundation

struct Line {
    let m: Double
    let b: Double
    let isVertical: Bool
    
    init(point1: Point, point2: Point) {
        precondition(point1.x != point2.x || point1.y != point2.y)
        self.isVertical = point1.x == point2.x
        if self.isVertical {
            self.m = Double.infinity
            self.b = point1.y
        } else {
            self.m = (point2.y - point1.y) / (point2.x - point1.x)
            self.b = point2.y - self.m * point2.x
        }
    }
    
    func satisfy(point: Point) -> Bool {
        if self.isVertical {
            return point.x == self.b
        } else {
            return point.y == (self.m * point.x + self.b)
        }
    }
}

struct Point {
    let x: Double
    let y: Double
}

struct Segment {
    let point1: Point
    let point2: Point
    init(point1: Point, point2: Point) {
        precondition(point1.x != point2.x || point1.y != point2.y)
        self.point1 = point1
        self.point2 = point2
    }
}

struct Square {
    let middlePoint: Point
    let size: Double
    
    init(middle: Point, size: Double) {
        precondition(size >= 0.0)
        self.middlePoint = middle
        self.size = size
    }
    
    func getBisectingSegment(_ square: Square) -> Segment {
        let line = Line(point1: self.middlePoint, point2: square.middlePoint)
        var intersections = [Point]()
        let intersectionsS1 = self.getIntersections(line: line)!
        let intersectionsS2 = square.getIntersections(line: line)!
        intersections.append(intersectionsS1.p1)
        intersections.append(intersectionsS1.p2)
        intersections.append(intersectionsS2.p1)
        intersections.append(intersectionsS2.p2)
        intersections.sort{ (point1, point2) in
            if point1.x == point2.x {
                return point1.y < point2.y
            } else {
                return point1.x < point2.x
            }
        }
        return Segment(point1: intersections.first!, point2: intersections.last!)
    }
}

private extension Square {
    func getBisectingLine(_ square: Square) -> Line {
        return Line(point1: self.middlePoint, point2: square.middlePoint)
    }
    
    func getIntersections(line: Line) -> (p1: Point, p2: Point)? {
        if !line.satisfy(point: self.middlePoint) {
            return nil
        }
        let halfSize = self.size / 2.0
        if line.isVertical {
            let p1 = Point(x: self.middlePoint.x, y: self.middlePoint.y + halfSize)
            let p2 = Point(x: self.middlePoint.x, y: self.middlePoint.y - halfSize)
            return (p1, p2)
        } else if abs(line.m) < 1 {
            let x1 = self.middlePoint.x + halfSize
            let x2 = self.middlePoint.x - halfSize
            let p1 = Point(x: x1, y: line.m * x1 + line.b)
            let p2 = Point(x: x2, y: line.m * x2 + line.b)
            return (p1, p2)
        } else {
            let y1 = self.middlePoint.y + halfSize
            let y2 = self.middlePoint.y - halfSize
            let p1 = Point(x: (y1 - line.b) / line.m, y: y1)
            let p2 = Point(x: (y2 - line.b) / line.m, y: y2)
            return (p1, p2)
        }
        
    }
}

let point1 = Point(x: 4.0, y: 2.0)
let point2 = Point(x: 3.0, y: 0.0)
let square1 = Square(middle: point1, size: 5.0)
let square2 = Square(middle: point2, size: 5.0)
let bisectingSegment = square1.getBisectingSegment(square2)
print("Point 1: (x: \(point1.x), y: \(point1.y))")
print("Point 2: (x: \(point2.x), y: \(point2.y))")
print("Bisecting segment: (x: \(bisectingSegment.point1.x), y: \(bisectingSegment.point1.y)) to (x: \(bisectingSegment.point2.x), y: \(bisectingSegment.point2.y))")


