//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

//Superman has at least two powers that normal mortals do not possess, namely, x-ray vision and the
//ability to fly faster than a speeding bullet. Some of his other skills are not so impressive: you
//or I could probably change clothes in a telephone booth if we put our minds to it.
//
//Superman seeks to demonstrate his powers between his current position s = (xs, ys) and a target
//position t = (xt, yt). The environment is filled with circular (or cylindrical) obstacles.
//Superman’s x-ray vision does not have unlimited range, being bounded by the amount of material he
//has to see through. He is eager to compute the total obstacle intersection length between the two
//points to know whether to attempt this trick.
//
//Failing this, the Man of Steel would like to fly between his current position and the target. He
//can see through objects, but not fly through them. His desired path flies straight to the goal,
//until it bumps into an object. At this point, he flies along the boundary of the circle until he
//returns to the straight line linking position to his start and end positions. This is not the
//shortest obstacle-free path, but Superman is not completely stupid – he always takes the shorter
//of the two arcs around the circle.
//
//You may assume that none of the circular obstacles intersect each other, and that both the start
//and target positions lie outside of obstacles. Circles are specified by giving the center
//coordinates and radius.

import Foundation

func pointInBox(point1: Point, point2: Point, target: Point) -> Bool {
    let (x1, x2) = point1.x > point2.x ? (point2.x, point1.x) : (point1.x, point2.x)
    let (y1, y2) = point1.y > point2.y ? (point2.y, point1.y) : (point1.y, point2.y)
    return target.x >= x1 && target.x <= x2 && target.y >= y1 && target.y <= y2
}

func printSupermanTrajectory(origin: Point, destination: Point, circles: [Circle]) {
    let line = Line(point1: origin, point2: destination)
    var xray: Double = 0.0
    var around: Double = 0.0
    
    for circle in circles {
        let closestPoint = line.findClosestPoint(toPoint: circle.center)
        let distance = closestPoint.distance(to: circle.center)
        let inBox = pointInBox(point1: origin, point2: destination, target: closestPoint)
        if distance >= 0.0 && distance < circle.radio && inBox {
            let angle = acos(( distance / circle.radio ))
            xray += 2 * sqrt( pow(circle.radio, 2.0) - pow(distance, 2.0))
            around += ( ( 2 * angle ) / ( 2 * Double.pi ) ) * ( Double.pi * 2 * circle.radio )
        }
    }
    let finalDistance = origin.distance(to: destination)
    let travel = finalDistance - xray + around
    let output = String(format: "Superman sees thru %.4f units, and flies %.4f units, the total distance is %.4f", xray, travel, finalDistance)
    print(output)
    
}


let origin = Point(x: 0.0, y: 0.0)
let destination = Point(x: 18.0, y: 0.0)
var circles = [Circle]()
circles.append(Circle(radio: 4.0, center: Point(x: 8.0, y: 0.0)))
printSupermanTrajectory(origin: origin, destination: destination, circles: circles)

