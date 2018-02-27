//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Jigsaw

import Foundation

enum Orientation {
    case left
    case top
    case right
    case bottom
}

enum Shape {
    case inner
    case outer
    case flat
    
    func getOpposite() -> Shape? {
        switch(self) {
        case .inner:
            return .outer
        case .outer:
            return .inner
        default:
            return nil
        }
    }
}

class Edge {
    let shape: Shape
    unowned let parent: Piece
    
    init(parent: Piece, shape: Shape) {
        self.parent = parent
        self.shape = shape
    }
    
    func fits(withShape shape: Shape) -> Bool {
        return shape == self.shape.getOpposite()
    }
}

class Piece {
    private(set) var edges: [Orientation: Edge]
    
    init(shapes: (top: Shape, bottom: Shape, left: Shape, right: Shape)) {
        self.edges = [.top: Edge(parent: self, shape: shapes.top),
                    .bottom: Edge(parent: self, shape: shapes.bottom),
                    .left: Edge(parent: self, shape: shapes.left),
                    .right: Edge(parent: self, shape: shapes.right)]
    }
    
    func rotateEdges(by: Int) {
        // Re-assigns the edges according to a number of rotations
    }
    
    func setInOrientation(edge: Edge, orientation: Orientation) {
        // Rotates the piece, so that the indicated edge ends in the indicated orientation
    }
    
    var isCorner: Bool {
        // Determines if the piece is a corner
        return false
    }
    
    var isBorder: Bool {
        // Determines if the piece is in the border of the board
        return false
    }
}

class Puzzle {
    private var remainingPieces: [Piece]
    private var solution: [[Piece?]]
    private let size: Int
    
    init(size: Int) {
        self.size = size
        self.solution = [[Piece?]](repeating: [Piece?](repeating: nil, count: size), count: size)
        let exampleShapes: (Shape, Shape, Shape, Shape) = (.inner, .inner, .outer, .outer)
        // The pieces should be determined in a way that the whole group of pieces could
        // complete a Jigsaw puzzle.
        self.remainingPieces = [Piece](repeating: Piece(shapes: exampleShapes), count: size)
    }
    
    // Set a piece in the solution using an indicated orientation
    func setEdgeInSolution(edge: Edge, row: Int, column: Int, orientation: Orientation) {
        let piece = edge.parent
        piece.setInOrientation(edge: edge, orientation: orientation)
        if let removeIndex = self.remainingPieces.index(where: { $0 === piece }) {
            self.remainingPieces.remove(at: removeIndex)
        }
        self.solution[row][row] = piece
    }
}
