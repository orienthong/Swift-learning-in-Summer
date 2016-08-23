//
//  ShapeFactory.swift
//  DesignPatternsInSwift
//
//  Created by 洪浩东 on 8/23/16.
//  Copyright © 2016 RepublicOfApps, LLC. All rights reserved.
//

import Foundation
import UIKit

protocol ShapeFactory {
  func creatShapes() -> (Shape, Shape)
}

class SquareShapeFactory: ShapeFactory {
  var minProportion: CGFloat
  var maxProportion: CGFloat
  
  init(minProportion: CGFloat, maxProportion: CGFloat) {
    self.minProportion = minProportion
    self.maxProportion = maxProportion
  }
  
  func creatShapes() -> (Shape, Shape) {
    let shape1 = SquareShape()
    shape1.sideLength = Utils.randomBetweenLower(minProportion, andUpper: maxProportion)
    let shape2 = SquareShape()
    shape2.sideLength = Utils.randomBetweenLower(minProportion, andUpper: maxProportion)
    
    return (shape1, shape2)
  }
}
