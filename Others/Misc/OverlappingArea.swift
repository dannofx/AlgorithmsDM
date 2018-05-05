import Foundation

struct Point: Equatable {
  let x: Double
  let y: Double
  
  static func ==(_ lhs: Point, _ rhs: Point) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
  }
}

struct Rectangle: Equatable {
  let bottomLeft: Point
  let topRight: Point
  
  init(bottomLeft: Point, topRight: Point) {
    //TODO: Reasons of precondition failure
    precondition(bottomLeft.x != topRight.x)
    precondition(bottomLeft.y != topRight.y)
    precondition(bottomLeft.x < topRight.x)
    precondition(bottomLeft.y < topRight.y)
    self.bottomLeft =  bottomLeft
    self.topRight = topRight
  }
  
  func overlappingArea(_ other: Rectangle) -> Double? {
    if self == other {
      return (self.topRight.x - self.bottomLeft.x) * (self.topRight.y - self.bottomLeft.y)
    }
    // Get X values
    var xValues = [self.bottomLeft.x, self.topRight.x, other.bottomLeft.x, other.topRight.x]
    xValues = xValues.sorted()
    let firstX = xValues[1]
    let secondX = xValues[2]
    if !self.isBetweenXPoints(firstX) &&
       !self.isBetweenXPoints(secondX) &&
       !other.isBetweenXPoints(firstX) &&
       !other.isBetweenXPoints(secondX) {
      return nil
    }
    // Get y values
    var yValues = [self.bottomLeft.y, self.topRight.y, other.bottomLeft.y, other.topRight.y]
    yValues = yValues.sorted()
    let firstY = yValues[1]
    let secondY = yValues[2]
    if !self.isBetweenYPoints(firstY) &&
       !self.isBetweenYPoints(secondY) &&
       !other.isBetweenYPoints(firstY) &&
       !other.isBetweenYPoints(secondY) {
      return nil
    }
    // Get final area
    let width = secondX - firstX
    let height = secondY - firstY
    return width * height
    
  }
  
  static func ==(_ lhs: Rectangle, _ rhs: Rectangle) -> Bool {
    return lhs.bottomLeft == rhs.bottomLeft &&
            lhs.topRight == rhs.topRight
  }
  
}

private extension Rectangle {
  
  func isBetween(value: Double, start: Double, end: Double) -> Bool {
    return start < value && value < end
  }
  
  func isBetweenXPoints(_ value: Double) -> Bool {
    return isBetween(value: value, start: self.bottomLeft.x, end: self.topRight.x)
  }
  
  func isBetweenYPoints(_ value: Double) -> Bool {
    return isBetween(value: value, start: self.bottomLeft.y, end: self.topRight.y)
  }
}

let r1BottomLeft = Point(x: -100.0, y: 0.0)
let r1TopRight = Point(x: 0.0, y: 100.0)
let rectangle1 = Rectangle(bottomLeft: r1BottomLeft, topRight: r1TopRight)
let r2BottomLeft = Point(x: 1.0, y: 1.0)
let r2TopRight = Point(x: 99.0, y: 99.0)
let rectangle2 = Rectangle(bottomLeft: r2BottomLeft, topRight: r2TopRight)
print(rectangle2.overlappingArea(rectangle1))