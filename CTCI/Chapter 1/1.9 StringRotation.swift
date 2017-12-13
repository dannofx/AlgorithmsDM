// String Rotation

import Foundation

extension String {
    func isSubstring(_ string: String) -> Bool {
        return self.range(of: string) != nil
    }
    
    func isRotation(_ string: String) -> Bool {
        if string.count == 0 || string.count != self.count {
            return false
        }
        let superString = self + self
        return superString.isSubstring(string)
    }
}



let string1 = "waterbottle"
let string2 = "erbottlewat"
print("\"\(string1)\" is rotation of \"\(string2)\": \(string1.isRotation(string2))")

