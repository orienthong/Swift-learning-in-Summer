//
//  ShapeViewFactory.swift
//  DesignPatternsInSwift
//
//  Created by 洪浩东 on 8/23/16.
//  Copyright © 2016 RepublicOfApps, LLC. All rights reserved.
//

import Foundation
import UIKit

protocol ShapeViewFactory {
  var size: CGSize { get set }
  func makeShapeViewsForShapes(shapes: (Shape, Shape)) -> (ShapeView, ShapeView)
}

class SquareShapeViewFactory: ShapeViewFactory {
  var size: CGSize
  
  init(size: CGSize) {
    self.size = size
  }
  
  func makeShapeViewsForShapes(shapes: (Shape, Shape)) -> (ShapeView, ShapeView) {
    let squareShape1 = shapes.0 as! SquareShape
    let shapeView1 = SquareShapeView(frame: CGRect(x: 0, y: 0, width: squareShape1.sideLength * size.width , height: squareShape1.sideLength * size.height))
    shapeView1.shape = squareShape1
    
    let squareShape2 = shapes.1 as! SquareShape
    let shapeView2 = SquareShapeView(frame: CGRect(x: 0, y: 0, width: squareShape2.sideLength * size.width, height: squareShape2.sideLength * size.height))
    shapeView2.shape = squareShape2
    
    return (shapeView1, shapeView2)
  }
}
