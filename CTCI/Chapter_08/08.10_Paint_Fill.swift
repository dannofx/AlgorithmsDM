//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Paint Fill

import Foundation

typealias Position = (row: Int, column: Int)


func paintFill(color: Int, position: Position, image: inout [[Int]], currentColor: Int? = nil) {
    if image.count == 0 || image[0].count == 0 ||
       position.row < 0 || position.column < 0 ||
        position.row >= image.count || position.column >= image[0].count ||
        image[position.row][position.column] == color ||
        (currentColor != nil && image[position.row][position.column] != currentColor) {
        return
    }
    let deltas = [
                  (0, -1),
        (-1, 0 ),          (1, 0 ),
                  (0, 1 )
    ]
    let currentColor = image[position.row][position.column]
    image[position.row][position.column] = color
    for delta in deltas {
        var nextPosition = position
        nextPosition.row += delta.0
        nextPosition.column += delta.1
        paintFill(color: color, position: nextPosition, image: &image, currentColor: currentColor)
    }
}

var width = 4
var height = 4
var image = [[Int]](repeating: [Int](repeating: 0, count: height), count: width)

let limit = min(width, height)
// Paints a diagonal line
for i in 0..<limit {
    image[i][i] = 255
}

paintFill(color: 33, position: (2,3), image: &image)
print("Image: ")
for row in image {
    print(row)
}

