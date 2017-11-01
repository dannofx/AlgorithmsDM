// 14.7.1 Herding Frosh

// One day, a lawn in the center of campus became infested with frosh. In an effort to
// beautify the campus, one of our illustrious senior classmen decided to round them up
// using a length of pink silk. Your job is to compute how much silk was required to
// complete the task.

// The senior classman tied the silk to a telephone post, and walked around the perimeter
// of the area containing the frosh, drawing the silk taught so as to encircle all of them.
// He then returned to the telephone post. The senior classman used the minimum amount of
// silk necessary to encircle all the frosh plus one extra meter at each end to tie it.

// You may assume that the telephone post is at coordinates (0,0), where the first
// dimension is north/south and the second dimension is east/west. The coordinates of the
// frosh are given in meters relative to the post. There are no more than 1,000 frosh.

import Foundation

// MARK: Modified convex hull Graham's algorithm

extension Polygon {
    
    static func createConvexHullPolygon(withPoints points: [Point], fixedPoint: Point) -> Polygon {
        var allPoints = points
        allPoints.append(fixedPoint)
        if allPoints.count <= 3 {
            let polygon = Polygon(points: allPoints)
            return polygon
        }
        var polygonPoints = [Point]()
        var sortedPoints = self.sortAndRemoveDuplicates(points: allPoints)
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
            if cw(pointA: polygonPoints[top - 1], pointB: polygonPoints[top], pointC: sortedPoints[i]) ||
                fixedPoint.isSamePoint(polygonPoints[top]) {
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
}

func getSilkAmount(froshes: [Point], post: Point) -> Double {
    let polygon = Polygon.createConvexHullPolygon(withPoints: froshes, fixedPoint: post)
    var total = 2.0
    for i in 0..<polygon.points.count {
        let j = ( i + 1 ) % polygon.points.count
        total += polygon.points[i].distance(to: polygon.points[j])
    }
    return total
}

let post = Point(x: 0.0, y: 0.0)
var froshes = [Point]()
froshes.append(Point(x: 1.0, y: 1.0))
froshes.append(Point(x: -1.0, y: 1.0))
froshes.append(Point(x: -1.0, y: -1.0))
froshes.append(Point(x: 1.0, y: -1.0))
let total = getSilkAmount(froshes: froshes, post: post)
print("Total amount of silk \(total)")



