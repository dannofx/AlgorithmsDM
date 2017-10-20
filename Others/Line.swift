//
//  Line.swift
//  EraseMe
//
//  Created by Danno on 10/19/17.
//  Copyright © 2017 Daniel Heredia. All rights reserved.
//

import Foundation

let epsilon = 0.00001

struct Point {
    var x: Double
    var y: Double
    
    func distance(to point: Point) -> Double{
        return sqrt(( pow((point.x - self.x), 2.0) + pow((point.y - self.y), 2.0) ))
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
        let x: Double = (line.b * self.c - self.b - line.c) / (line.a * self.b - self.a * line.b)
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
            let line = Line(slope: (1 / self.a), point: point)
            result = self.findIntersection(line: line)!
        }
        return result
    }
}
