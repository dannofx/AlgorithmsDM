
import Foundation

// Error range
let epsilon = 0.00001
// Operators to manage error range
infix operator <<=: AdditionPrecedence
infix operator >>=: AdditionPrecedence
infix operator ====: AdditionPrecedence
infix operator !===: AdditionPrecedence

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

// MARK: Line structure

struct Line {
    var a: Double // X coefficcient
    var b: Double // Y coefficcient
    var c: Double // Constant term
    
    init(a: Double, b: Double, c: Double) {
        self.a = a
        self.b = b
        self.c = c
    }
    
    init(point1: Point, point2: Point) {
        let vx = point2.x - point1.y
        let vy = point2.y - point1.y
        self.a = vy
        self.b = vx * -1
        self.c = point1.y * vx  - point1.x * vy
    }
    
    init(slope: Double, point: Point) {
        // From m = (y2 - y1) / (x2 - x1)
        // we deduce the following values.
        self.a = slope
        self.b = -1
        self.c = -1 * slope * point.x + point.y
    }
    
    func isParallel(line: Line) -> Bool {
        if line.a ==== 0.0 {
            return self.a ==== 0.0
        }
        if line.b ==== 0.0 {
            return self.b ==== 0.0
        }
        let proportionA = self.a / line.a
        let proportionB = self.b / line.b
        return proportionA ==== proportionB
    }
    
    func isSameLine(_ line: Line) -> Bool {
        if !self.isParallel(line: line) {
            return false
        }
        if line.c ==== 0.0 {
            return self.c ==== 0.0
        } else {
            let proportionB = self.b / line.b
            let proportionC = self.c / line.c
            return proportionB ==== proportionC
        }
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
        let x = (self.b * line.c - line.b * self.c ) / ( line.b * self.a - self.b * line.a )
        let y = (self.a * line.c - line.a * self.c ) / ( line.a * self.b - self.a * line.b )
        return Point(x: x, y: y)
    }
    
    func findClosestPoint(toPoint point: Point) -> Point {
        // General equation of perpendicular line
        // -Bx + Ay + k = 0
        // k = Bx -Ay
        let pA = self.b * -1
        let pB = self.a
        let pC = self.b * point.x - self.a * point.y
        let perpendicularLine = Line(a: pA, b: pB, c: pC)
        return self.findIntersection(line: perpendicularLine)!
    }
    
    func liesOnLine(point: Point) -> Bool {
        let sum = self.a * point.x + self.b * point.y + self.c
        return sum ==== 0.0
    }
}

let line1 = Line(slope: 0.0, point: Point(x: 5.0, y: 5.0))
let line2 = Line(slope: 0.0, point: Point(x: 0.0, y: 5.0))
print("Line 1: \(line1)")
print("Line 2: \(line2)")
print("Parallel: \(line1.isParallel(line: line2))")
print("Same line: \(line1.isSameLine(line2))")
let intersectionString: String!
if let intersection = line1.findIntersection(line: line2) {
    intersectionString = "(x:\(intersection.x), y:\(intersection.y))"
} else {
    intersectionString = "(not found)"
}
print("Intersection: \(intersectionString ?? "")")
let testPoint = Point(x: -1.0, y: 5.0)
print("Closes line1 point to \(testPoint): \(line1.findClosestPoint(toPoint: testPoint))")
print("Point \(testPoint) lies on line1: \(line1.liesOnLine(point: testPoint))")

