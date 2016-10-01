//
//  Turn.swift
//  DesignPatternsInSwift
//
//  Created by 洪浩东 on 8/23/16.
//  Copyright © 2016 RepublicOfApps, LLC. All rights reserved.
//

import Foundation

class Turn {
  let shapes: [Shape]
  var mached: Bool?
  
  init(shapes: [Shape]) {
    self.shapes = shapes
  }
  
  func turnCompletedWithTappedShape(tappedShape: Shape) {
    let maxArea = shapes.reduce(0, combine: {
      $0 > $1.area ? $0 : $1.area
    })
    mached = tappedShape.area >= maxArea
  }
}