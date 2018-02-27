//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// T9

import Foundation

// No tested yet

extension String {
    subscript(i: Int) -> Character {
        get {
            let index = self.index(self.startIndex, offsetBy: i)
            return self[index]
        }
    }
    
    var isNumber: Bool {
        return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}

let t9Letters: [[Character]] = [
    [], //0
    [], //1
    ["a", "b", "c"], //2
    ["d", "e", "f"], //3
    ["g", "h", "i"], //4
    ["j", "k", "l"], //5
    ["m", "n", "o"], //6
    ["p", "q", "r", "s"], //7
    ["t", "u", "v"], //8
    ["w", "x", "y", "z"] //9
]

class TreeNode {
    private(set) var isCompleteWord: Bool
    private(set) var children: [Character: TreeNode]
    private(set) var character: Character
    
    init(character: Character) {
        self.isCompleteWord = false
        self.children = [Character: TreeNode]()
        self.character = character
    }
    
    func addSuffix(_ suffix: String) {
        if suffix.count == 0 {
            self.isCompleteWord = true
            return
        }
        let letter = suffix[0]
        let child = self.children[letter] ?? TreeNode(character: letter)
        var newSuffix = suffix
        newSuffix.removeFirst()
        child.addSuffix(newSuffix)
    }
}

func findWords(number: String, index: Int, prefix: String, treeNode: TreeNode, results: inout [String]) {
    if index == number.count {
        if treeNode.isCompleteWord {
            results.append(prefix)
        }
        return
    }
    let digit = Int(String(number[index]))!
    let chars = t9Letters[digit]
    for char in chars {
        if let child = treeNode.children[char] {
            findWords(number: number,
                     index: index + 1,
                     prefix: prefix + String(char),
                     treeNode: child,
                     results: &results)
        }
    }
}

func getWords(forNumber number: String, suffixTree: TreeNode) -> [String] {
    precondition(number.isNumber)
    var results = [String]()
    findWords(number: number, index: 0, prefix: "", treeNode: suffixTree, results: &results)
    return results
}
