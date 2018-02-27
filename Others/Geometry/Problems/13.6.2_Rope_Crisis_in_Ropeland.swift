//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// 13.6.2 Rope Crisis in Ropeland!


//Rope-pulling (also known as tug of war) is a very popular game in Ropeland, just
//like cricket is in Bangladesh. Two groups of players hold different ends of a rope
//and pull. The group that snatches the rope from the other group is declared
//winner.
//Due to a rope shortage, the king of the country has declared that groups will not
//be allowed to buy longer ropes than they require.
//Rope-pulling takes place in a large room, which contains a large round pillar of a
//certain radius. If two groups are on the opposite side of the pillar, their pulled
//rope cannot be a straight line. Given the position of the two groups, find out the
//minimum length of rope required to start rope-pulling. You can assume that a point
//represents the position of each group.

import Foundation

func totalRope(circle: Circle, pointA: Point, pointB: Point) -> Double {
    if let segmentDistance = circle.findClosestDistanceToSegment(pointA, pointB), segmentDistance < circle.radius {
        let centerDistanceA = circle.center.distance(to: pointA)
        let centerDistanceB = circle.center.distance(to: pointB)
        let extAngleA = acos(segmentDistance / centerDistanceA)
        let extAngleB = acos(segmentDistance / centerDistanceB)
        let tangentDistanceA = sqrt( pow(centerDistanceA, 2.0) - pow(circle.radius, 2.0) )
        let tangentDistanceB = sqrt( pow(centerDistanceA, 2.0) - pow(circle.radius, 2.0) )
        let intAngleA = asin(tangentDistanceA / centerDistanceA)
        let intAngleB = asin(tangentDistanceB / centerDistanceB)
        let angle = extAngleA + extAngleB - intAngleA - intAngleB
        let arcLen =  angle * circle.radius
        return arcLen + tangentDistanceA + tangentDistanceB
    } else {
        return pointA.distance(to: pointB)
    }
}

let pointA = Point(x: 1.0, y: 1.0)
let pointB = Point(x: -1.0, y: -1.0)
let center = Point(x: 0.0, y: 0.0)
let circle = Circle(radius: 1.0, center: center)
let totalLen = totalRope(circle: circle, pointA: pointA, pointB: pointB)
print("Total rope len \(totalLen)")



