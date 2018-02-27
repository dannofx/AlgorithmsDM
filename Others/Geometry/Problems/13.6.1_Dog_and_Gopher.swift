//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// 13.6.1 Dog and Gopher

//A large field has a dog and a gopher. The dog wants to eat the gopher, while the
//gopher wants to run to safety through one of several gopher holes dug in the surface
//of the field.
//Neither the dog nor the gopher is a math major; however, neither is entirely stupid.
//The gopher decides on a particular gopher hole and heads for that hole in a straight
//line at a fixed speed. The dog, which is very good at reading body language,
//anticipates which hole the gopher has chosen. The dog heads at double the speed of the
//gopher to the hole. If the dog reaches the hole first, the gopher gets gobbled up;
//otherwise, the gopher escapes.
//You have been retained by the gopher to select a hole through which it can escape, if
//such a hole exists.

import Foundation


let gopherPos = Point(x: 2.0, y: 2.0)
let dogPos = Point(x: 1.0, y: 1.0)
var holes = [Point]()
holes.append(Point(x: 1.5, y: 1.5))
holes.append(Point(x: 2.5, y: 2.5))

for hole in holes {
    let dogDistance = dogPos.distance(to: hole)
    let gopherDistance = gopherPos.distance(to: hole)
    if gopherDistance < (dogDistance / 2.0) {
        print("The gopher can escape through the hole at (\(hole.x), \(hole.y))")
        exit(0)
    }
}
print("The gopher cannot escape.")

