// Chapter 7, Exercise 7-19

import Foundation

func rng4() -> UInt32 {
    return arc4random_uniform(5)
}

func rng3() -> UInt32 {
    var res:UInt32 = 4
    while res > 3 {
        res = rng4()
    }
    return res
}

func rng1() -> UInt32 {
    var res:UInt32 = 4
    while res > 3 {
        res = rng4()
    }
    return res % 2
}

func rng7() -> UInt32 {
    return 2 * rng3() + rng1()
}

for _ in 0..<1000 {
    print("Random 0-7: \(rng7())")
}
