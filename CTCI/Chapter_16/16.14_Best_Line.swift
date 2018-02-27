//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Best Line

import Foundation

let epsilon = 0.000001
infix operator ====: AdditionPrecedence

extension Double {
    static func ===(lhs: Double, rhs: Double) -> Bool {
        return abs(lhs - rhs) < epsilon
    }
}

struct Line: Hashable {
    let m: Double
    let b: Double
    let isVertical: Bool
    
    init(point1: Point, point2: Point) {
        precondition(point1.x != point2.x || point1.y != point2.y)
        self.isVertical = point1.x == point2.x
        if self.isVertical {
            self.m = Double.infinity
            self.b = point1.x
        } else {
            self.m = (point2.y - point1.y) / (point2.x - point1.x)
            self.b = point2.y - self.m * point2.x
        }
    }
    
    var hashValue: Int {
        return self.m.hashValue & self.b.hashValue
    }
    
    static func ==(lhs: Line, rhs: Line) -> Bool {
        if lhs.isVertical && rhs.isVertical {
            return lhs.b === rhs.b
        } else {
            return lhs.m === rhs.m && lhs.b === rhs.b
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

struct Point: Hashable {
    let x: Double
    let y: Double
    
    var hashValue: Int {
        return x.hashValue ^ y.hashValue
    }
    
    static func ==(lhs: Point, rhs: Point) -> Bool {
        return lhs.x === rhs.x && lhs.y === rhs.y
    }
    
}

func countDuplicates(points: [Point]) -> [(p: Point, c: Int)] {
    var pointsMap = [Point: Int]()
    var pointCounts = [(p: Point, c: Int)]()
    for point in points {
        let count = pointsMap[point] ?? 0
        pointsMap[point] = count + 1
    }
    for (point, count) in pointsMap {
        pointCounts.append((point, count))
    }
    return pointCounts
}

func findAllLines(_ pointCounts: [(p: Point, c: Int)]) -> [Line: Int] {
    var lineCounts = [Line: Int]()
    for i in 0..<pointCounts.count {
        for j in (i + 1)..<pointCounts.count {
            let (point1, countP1) = pointCounts[i]
            let (point2, countP2) = pointCounts[j]
            let line = Line(point1: point1, point2: point2)
            let count = lineCounts[line] ?? 0
            lineCounts[line] = count + countP1 + countP2
        }
    }
    return lineCounts
}

func findBestLine(points: [Point]) -> Line {
    precondition(points.count > 1)
    let pointCounts = countDuplicates(points: points)
    let lineCounts = findAllLines(pointCounts)
    var maxPoints = 0
    var bestLine: Line!
    for (line, count) in lineCounts {
        if count > maxPoints {
            maxPoints = count
            bestLine = line
        }
    }
    return bestLine
}

var points = [Point]()
points.append(Point(x: 0.0, y: 0.0))
points.append(Point(x: 5.0, y: 5.0))
points.append(Point(x: 6.0, y: 2.0))
points.append(Point(x: 0.0, y: 17.0))
points.append(Point(x: 0.0, y: 15.0))
points.append(Point(x: -3.0, y: 3.0))
points.append(Point(x: 7.0, y: 7.0))
points.append(Point(x: 3.0, y: -3.0))
points.append(Point(x: 3.0, y: 0.0))
points.append(Point(x: 12.0, y: 15.0))
points.append(Point(x: 4.0, y: 8.0))
points.append(Point(x: 12.0, y: 12.0))

let bestLine = findBestLine(points: points)
print("Best line:  \(bestLine)")

