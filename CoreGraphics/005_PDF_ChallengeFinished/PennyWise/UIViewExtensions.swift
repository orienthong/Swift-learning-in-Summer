//
//  UIViewExtensions.swift
//  PennyWise
//
//  Created by Caroline Begbie on 3/03/2016.
//  Copyright © 2016 Caroline. All rights reserved.
//

import UIKit

extension UIView {

  func drawGradient(startColor:UIColor, endColor: UIColor, startPoint:CGPoint, endPoint:CGPoint) {
    
    let colors = [startColor.CGColor, endColor.CGColor]
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let colorLocations:[CGFloat] = [0.0, 1.0]
    let gradient = CGGradientCreateWithColors(colorSpace, colors, colorLocations)
    let context = UIGraphicsGetCurrentContext()
    
    CGContextDrawLinearGradient(context,
          gradient,
          startPoint,
          endPoint,
          [])
    
  }
  
}
