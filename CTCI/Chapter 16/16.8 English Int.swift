// English Int

import Foundation

func describeTens(_ n: Int) -> String {
    var description = ""
    switch n {
    case 0:
        description = ""
    case 1:
        description = ""
    case 2:
        description = " Twenty"
    case 3:
        description = " Thirty"
    case 4:
        description = " Forty"
    case 5:
        description = " Fifty"
    case 6:
        description = " Sixty"
    case 7:
        description = " Seventy"
    case 8:
        description = " Eighty"
    case 9:
        description = " Ninety"
    default:
        break
    }
    return description
}

func describeSmallNumber(_ n: Int) -> String {
    var description = ""
    switch n {
    case 0:
        description = " Zero"
    case 1:
        description = " One"
    case 2:
        description = " Two"
    case 3:
        description = " Three"
    case 4:
        description = " Four"
    case 5:
        description = " Five"
    case 6:
        description = " Six"
    case 7:
        description = " Seven"
    case 8:
        description = " Eight"
    case 9:
        description = " Nine"
    case 10:
        description = " Ten"
    case 11:
        description = " Eleven"
    case 12:
        description = " Twelve"
    case 13:
        description = " Thirteen"
    case 14:
        description = " Fourteen"
    case 15:
        description = " Fifteen"
    case 16:
        description = " Sixteen"
    case 17:
        description = " Seventeen"
    case 18:
        description = " Eighteen"
    case 19:
        description = " Nineteen"
    default:
        break
    }
    return description
}

func describeSuffix(_ n: Int, plural: Bool) -> String {
    let lastLet = plural ? "s" : ""
    switch n {
    case 0:
        return ""
    case 1:
        return " Thounsand\(lastLet)"
    case 2:
        return " Million\(lastLet)"
    case 3:
        return " Billion\(lastLet)"
    default:
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

let n: Int = -9_100_001_987_505_222_010
let description = describeNumber(n)
print("\(n): \(description)")
