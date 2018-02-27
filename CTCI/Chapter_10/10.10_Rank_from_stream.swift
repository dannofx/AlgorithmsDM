//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Rank from stream

import Foundation

class TreeNode {
    private var smaller: TreeNode?
    private var larger: TreeNode?
    let value: Int
    private(set) var rank: Int
    
    init(value: Int) {
        self.value = value
        self.rank = 0
    }
    
    func track(value: Int) {
        let node = TreeNode(value: value)
        self.track(node: node)
    }
    
    func getRank(value: Int) -> Int? {
        if let (_, rank) = self.findNodeWithRank(value: value, previousRank: 0) {
            return rank
        } else {
            return nil
        }
    }
}

// MARK: - Private methods
private extension TreeNode {
    
    func track(node: TreeNode) {
        if node.value == value {
            self.rank += 1
        } else if node.value > self.value {
            if let larger = self.larger {
                larger.track(node: node)
            } else {
                self.larger = node
            }
        } else {
            self.rank += 1
            if let smaller = self.smaller {
                smaller.track(node: node)
            } else {
                self.smaller = node
            }
        }
    }
   
    func findNodeWithRank(value: Int, previousRank: Int) -> (TreeNode, Int)? {
        let currentRank = self.rank + previousRank
        if self.value == value {
            return (self, currentRank)
        } else if value > self.value {
            if let larger = self.larger {
                return larger.findNodeWithRank(value:value, previousRank: currentRank + 1)
            } else {
                return nil
            }
        } else {
            if let smaller = self.smaller {
                return smaller.findNodeWithRank(value:value, previousRank: previousRank)
            } else {
                return nil
            }
        }
    }
    
}

var node = TreeNode(value: 5)
node.track(value: 1)
node.track(value: 4)
node.track(value: 4)
node.track(value: 5)
node.track(value: 9)
node.track(value: 7)
node.track(value: 13)
node.track(value: 3)
let values = [1,3,4]
for value in values {
    if let rank = node.getRank(value: value) {
        print("Rank for \(value): \(rank)")
    } else {
        print("No rank for \(value)")
    }
}



