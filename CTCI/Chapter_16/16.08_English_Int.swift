//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// English Int

import Foundation

let smallNumbers = [" Zero", " One", " Two", " Three", " Four", " Five", " Six", " Seven", " Eight", " Nine", " Ten", " Eleven", " Twelve", " Thirteen", " Fourteen", " Fifteen", " Sixteen", " Seventeen", " Eighteen", " Nineteen"]
let tens = ["", "", " Twenty", " Thirty", " Forty", " Fifty", " Sixty", " Seventy", " Eighty", " Ninety"]
let suffixes = ["", " Thounsand", " Million", " Billion"]

func describeTens(_ n: Int) -> String {
    if n < 0 || n >= tens.count {
        return ""
    }
    return tens[n]
}

func describeSmallNumber(_ n: Int) -> String {
    if n < 0 || n >= smallNumbers.count {
        return ""
    }
    return smallNumbers[n]
}

func describeSuffix(_ n: Int, plural: Bool) -> String {
    let lastLet = plural ? "s" : ""
    if n <= 0 {
        return ""
    } else if n < 4 {
        return "\(suffixes[n])\(lastLet)"
    } else {
        let prefix = describeSuffix(n - 3, plural: plural)
        return "\(prefix) of Billions"
    }
}

func describeHundredGroup(_ n: Int) -> String {
    var description = ""
    let hundreds = n / 100
    if hundreds > 0 {
        description.append("\(describeSmallNumber(hundreds)) Hundred")
    }
    let tens = (n % 100) / 10
    if tens > 1 {
        description.append(describeTens(tens))
    }
    let units = n % 20
    if units > 0 {
        description.append(describeSmallNumber(units))
    }
    return description
}

func describeNumber(_ n: Int) -> String {
    if n == 0 {
        return describeSmallNumber(n)
    }
    var description = ""
    if n < 0 {
        description.append("Negative")
        description.append(describeNumber(n * -1))
        return description
    }
    var number = n
    var i = 0
    var groupDescriptions = [String]()
    while number > 0 {
        let hundreds = number % 1000
        if hundreds > 0 {
            let hunDesc = describeHundredGroup(hundreds)
            let suffix = describeSuffix(i, plural: hundreds > 1)
            let comma = groupDescriptions.count > 0 ? "," : ""
            groupDescriptions.append("\(hunDesc)\(suffix)\(comma)")
        }
        number /= 1000
        i += 1
    }
    while groupDescriptions.count > 0{
        let last = groupDescriptions.removeLast()
        description.append(last)
    }
    return description
}

let n: Int = -9_100_001_987_505_222_121
let description = describeNumber(n)
print("\(n): \(description)")
