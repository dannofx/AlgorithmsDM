// 13.6.4 Chocolate Chip Cookies

//Making chocolate chip cookies involves mixing flour, salt, oil, baking soda, and
//choco late chips to form dough, which is then rolled into a plane about 50 cm square.
//Circles are cut from this plane, placed on a cookie sheet, and baked in an oven for about
//20 minutes. When the cookies are done, they are removed from the oven and allowed to cool
//before being eaten.

//We are concerned here with the process of cutting the first cookie after the dough has
//been rolled. Each chip is visible in the planar dough, so we simply need to place the
//cutter so as to maximize the number of chocolate chips contained in its perimeter.

import Foundation

func getCenter(point1: Point, point2: Point) -> Point {
    let x = ( point1.x + point2.x ) / 2.0
    let y = ( point1.y + point2.y ) / 2.0
    return Point(x: x, y: y)
}

func countChips(center: Point, chocoChips: [Point], cookieRadio: Double) -> Int {
    var chips = 0
    for chocoChip in chocoChips {
        let distance = center.distance(to: chocoChip)
        if distance <= cookieRadio {
            chips += 1
        }
    }
    return chips
}

func getCircumferencesCenters(point1: Point, point2: Point, radio: Double) -> (c1: Point, c2: Point) {
    let line = Line(point1: point1, point2: point2)
    let bisecCenter = getCenter(point1: point1, point2: point2)
    let bisecLine: Line!
    if abs(line.a) <= epsilon {
        bisecLine = Line(point1: bisecCenter, point2: bisecCenter)
    } else {
        bisecLine = Line(slope: (1.0 / line.a), point: bisecCenter)
    }
    let module = sqrt(pow(bisecLine.a, 2.0) + pow(bisecLine.b, 2.0))
    let unitX = bisecCenter.x / module
    let unitY = bisecCenter.y / module
    let d = sqrt( pow(radio, 2.0) - pow(bisecCenter.distance(to: point1), 2.0) )
    var cx = bisecCenter.x + d * unitX
    var cy = bisecCenter.y + d * unitY
    let center1 = Point(x: cx, y: cy)
    cx = bisecCenter.x - d * unitX
    cy = bisecCenter.y - d * unitY
    let center2 = Point(x: cx, y: cy)
    return (center1, center2)
}

func getMaxChipsNumber(_ chocoChips: [Point], cookieDiamenter: Double) -> Int {
    var maxChips = 0
    let cookieRadio = cookieDiameter / 2.0
    for i in 0..<chocoChips.count {
        let chipI = chocoChips[i]
        for j in (i + 1)..<chocoChips.count {
            let chipJ = chocoChips[j]
            let chipsDistance = chipI.distance(to: chipJ)
            if abs(chipsDistance - cookieDiameter) <= epsilon {
                let center = getCenter(point1: chipI, point2: chipJ)
                let chipsCount = countChips(center: center, chocoChips: chocoChips, cookieRadio: cookieRadio)
                maxChips = max(chipsCount, maxChips)
            } else {
                let centers = getCircumferencesCenters(point1: chipI, point2: chipJ, radio: cookieRadio)
                var chipsCount = countChips(center: centers.c1, chocoChips: chocoChips, cookieRadio: cookieRadio)
                maxChips = max(chipsCount, maxChips)
                chipsCount = countChips(center: centers.c2, chocoChips: chocoChips, cookieRadio: cookieRadio)
                maxChips = max(chipsCount, maxChips)
            }
        }
    }
    return maxChips
}

let cookieDiameter = 5.0
var chocoChips = [Point]()
chocoChips.append(Point(x: 4.0, y: 4.0))
chocoChips.append(Point(x: 4.0, y: 5.0))
chocoChips.append(Point(x: 5.0, y: 6.0))
chocoChips.append(Point(x: 1.0, y: 20.0))
chocoChips.append(Point(x: 1.0, y: 21.0))
chocoChips.append(Point(x: 1.0, y: 22.0))
chocoChips.append(Point(x: 1.0, y: 25.0))
chocoChips.append(Point(x: 1.0, y: 26.0))
let maxChips = getMaxChipsNumber(chocoChips, cookieDiamenter: cookieDiameter)
print("The maximum number of chips for a cookie is: \(maxChips)")




