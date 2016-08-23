//
//  GameViewController.swift
//  DesignPatternsInSwift
//
//  Created by Joel Shapiro on 9/23/14.
//  Copyright (c) 2014 RepublicOfApps, LLC. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    beginNextTurn()
  }

  override func prefersStatusBarHidden() -> Bool {
    return true
  }

  private func beginNextTurn() {
    let shape1 = SquareShape()
    shape1.sideLength = Utils.randomBetweenLower(0.3, andUpper: 0.8)
    let shape2 = SquareShape()
    shape2.sideLength = Utils.randomBetweenLower(0.3, andUpper: 0.8)

    let availSize = gameView.sizeAvailableForShapes()
    let shapeView1: ShapeView = SquareShapeView(frame: CGRect(x: 0, y: 0, width: availSize.width * shape1.sideLength, height: availSize.height * shape1.sideLength))
    shapeView1.shape = shape1
    let shapeView2: ShapeView = SquareShapeView(frame: CGRect(x: 0, y: 0, width: availSize.width * shape2.sideLength, height: availSize.height * shape2.sideLength))
    shapeView2.shape = shape2
    let shapeViews = (shapeView1, shapeView2)

    shapeViews.0.tapHandler = {
      tappedView in
      self.gameView.score += shape1.sideLength >= shape2.sideLength ? 1 : -1
      self.beginNextTurn()
    }
    shapeViews.1.tapHandler = {
      tappedView in
      self.gameView.score += shape2.sideLength >= shape1.sideLength ? 1 : -1
      self.beginNextTurn()
    }

    gameView.addShapeViews(shapeViews)
  }

  private var gameView: GameView { return view as! GameView }
}
