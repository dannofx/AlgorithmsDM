// Volume of histogram

import Foundation

func calculateVolume(histogram: [Int]) -> Int {
    var leftMaxes = [Int]()
    var leftMax = 0
    for bar in histogram {
        if bar > leftMax {
            leftMax = bar
        }
        leftMaxes.append(leftMax)
    }
    var volume = 0
    var rightMax = 0
    for i in stride(from: histogram.count - 1, through: 0, by: -1) {
        let bar = histogram[i]
        let leftMax = leftMaxes[i]
        let wLevel = min(rightMax, leftMax)
        if wLevel > bar {
            volume += wLevel - bar
        }
        if bar > rightMax {
            rightMax = bar
        }
    }
    return volume
}

let histogram = [0, 0, 4, 0, 0, 6, 0, 0, 3, 0, 5, 0, 1, 0, 0, 0]
let volume = calculateVolume(histogram: histogram)
print("Histogram: ")
print(histogram)
print("Water volume: \(volume)")
