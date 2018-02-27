//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// 14.7.5 Useless Tile Packers

// Useless Tile Packer, Inc., prides itself on efficiency. As their name suggests, they
// aim to use less space than other companies. Their marketing department has tried to
// convince management to change the name, believing that “useless” has other
// connotations, but has thus far been unsuccessful.

// Tiles to be packed are of uniform thickness and have a simple polygonal shape. For
// each tile, a container is custom-built. The floor of the container is a convex
// polygon that has the minimum possible space inside to hold the tile it is built for.

import Foundation

func calculateWastedAreaProportion(_ tile: Polygon) -> Double {
    let convexHullPolygon = tile.extractConvexHull()
    let tileArea = tile.area()
    let boxArea = convexHullPolygon.area()
    let proportion = tileArea / boxArea
    return 1.0 - proportion
}

var points = [Point]()

// first case
//points.append(Point(x: 0.0, y: 0.0))
//points.append(Point(x: 2.0, y: 0.0))
//points.append(Point(x: 2.0, y: 2.0))
//points.append(Point(x: 1.0, y: 1.0))
//points.append(Point(x: 0.0, y: 2.0))

// second case
points.append(Point(x: 0.0, y: 0.0))
points.append(Point(x: 0.0, y: 2.0))
points.append(Point(x: 1.0, y: 3.0))
points.append(Point(x: 2.0, y: 2.0))
points.append(Point(x: 2.0, y: 0.0))

let tile = Polygon(points: points)
let wastedProportion = calculateWastedAreaProportion(tile)
print("Wasted space: \(wastedProportion * 100)%")



