//
//  TurnController.swift
//  DesignPatternsInSwift
//
//  Created by 洪浩东 on 8/23/16.
//  Copyright © 2016 RepublicOfApps, LLC. All rights reserved.
//

import Foundation


class TurnController {
  var currentTurn: Turn?
  var pastTurns: [Turn] = [Turn]()
  private let shapeFactory: ShapeFactory
  private var shapeViewBuilder: ShapeViewBuilder
  
  // 2
  init(shapeFactory: ShapeFactory, shapeViewBuilder: ShapeViewBuilder) {
    self.shapeFactory = shapeFactory
    self.shapeViewBuilder = shapeViewBuilder
  }
  
  // 3
  func beginNewTurn() -> (ShapeView, ShapeView) {
    let shapes = shapeFactory.createShapes()
    let shapeViews = shapeViewBuilder.buildShapeViewsForShapes(shapes)
    currentTurn = Turn(shapes: [shapeViews.0.shape, shapeViews.1.shape])
    return shapeViews
  }
  
  // 4
  func endTurnWithTappedShape(tappedShape: Shape) -> Int {
    currentTurn!.turnCompletedWithTappedShape(tappedShape)
    pastTurns.append(currentTurn!)
    
    var scoreIncrement = currentTurn!.matched! ? 1 : -1
    
    return scoreIncrement
  }
  
}