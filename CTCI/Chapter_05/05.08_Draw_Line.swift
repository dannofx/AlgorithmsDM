//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Draw Line

import Foundation

extension UInt8 {

    var binaryString: String {
        return convertToBinaryString(size: UInt.bitWidth)
    }
    
    func convertToBinaryString(size: Int) -> String {
        let mask: UInt8 = ~(~0 << size)
        let number = mask & self
        let binaryForm = String(number, radix: 2)
        return String(repeatElement("0", count: size - binaryForm.count)) + binaryForm
    }

    func segmentToBinaryString(_ x1: Int, _ x2: Int) -> String? {
        if x1 > x2 || x1 >= 8 || x2 >= 8 {
            return nil
        }
        let value = self >> (8 - x2 - 1)
        return value.convertToBinaryString(size: x2 - x1 + 1)
    }
}

func drawLine(screen: inout [UInt8], width: Int, x1: Int, x2: Int, y: Int) {
    let bytesWidth = width / 8
    if x1 > x2 || x2 >= width || screen.count % bytesWidth != 0 || y >= screen.count / bytesWidth {
        return
    }
    let startOffset = x1 % 8
    var start = (x1 + y * width) / 8
    if startOffset != 0 {
        start += 1
    }
    let endOffset = x2 % 8
    var end = (x2 + y * width) / 8
    if endOffset != 7 {
        end -= 1
    }
    var i = start
    while i <= end {
        screen[i] = 0b11111111
        i += 1
    }
    let startMask: UInt8 = 0b11111111 >> startOffset
    let endMask: UInt8 = 0b11111111 << UInt8(7 - endOffset)
    if x1 / 8 == x2 / 8 {
        screen[start - 1] |= startMask & endMask
    } else {
        if startOffset != 0 {
            screen[start - 1] |= startMask
        }
        
        if endOffset != 7 {
            screen[end + 1] |= endMask
        }
    }
}
    
// This method is just to verify the changes
func getLine(screen: [UInt8], width: Int, x1: Int, x2: Int, y: Int) -> String? {
    let bytesWidth = width / 8
    if x1 > x2 || x2 >= width || screen.count % bytesWidth != 0 || y >= screen.count / bytesWidth {
        return nil
    }
    let rowPadding = bytesWidth * y
    let p1 = rowPadding + x1 / 8
    let p2 = rowPadding + x2 / 8
    var line = ""
    for i in p1...p2 {
        let iLine = (i % bytesWidth) * 8
        let first = iLine <= x1 ? x1 % 8 : 0
        let xDiff = x2 - iLine
        let second = xDiff < 8 ? xDiff : 7
        line.append(screen[i].segmentToBinaryString(first, second)!)
    }
    return line
}



let width = 32
let height = 3
var screen = [UInt8](repeating: 0, count: (width / 8) * height)
let y = 1
let x1 = 3
let x2 = 22
var line = getLine(screen: screen, width: width, x1: 0, x2: 31, y: y)!
print("Original line: \(line)")
print("Line drawn from \(x1) to \(x2)")
drawLine(screen: &screen, width: width, x1: x1, x2: x2, y: y)
line = getLine(screen: screen, width: width, x1: 0, x2: 31, y: y)!
print("Modified line: \(line)")



