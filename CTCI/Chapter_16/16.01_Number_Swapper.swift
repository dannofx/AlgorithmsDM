//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Number Swapper

import Foundation

func swapNumbers(_ a: inout Int, _ b: inout Int) {
    a = a ^ b
    b = a ^ b
    a = a ^ b
}

var a = 555
var b = 777
print("Initial values, a: \(a), b: \(b)")
swapNumbers(&a, &b)
print("Final values, a: \(a), b: \(b)")



