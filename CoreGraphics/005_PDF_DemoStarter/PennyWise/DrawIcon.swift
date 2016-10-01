/*
* Copyright (c) 2016 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

let drawingSize = CGSize(width: 400, height: 400)

class DrawIcon {
  
  class func drawAutoIcon() -> UIBezierPath {
    
    UIGraphicsBeginImageContextWithOptions(drawingSize, false, 0.0)
    
    //// Bezier Drawing
    let window = UIBezierPath()
    window.moveToPoint(CGPointMake(54.24, 163.06))
    window.addCurveToPoint(CGPointMake(107.83, 146.83), controlPoint1: CGPointMake(71.29, 144.12), controlPoint2: CGPointMake(107.83, 146.83))
    window.addCurveToPoint(CGPointMake(193.47, 77.5), controlPoint1: CGPointMake(107.83, 146.83), controlPoint2: CGPointMake(135, 77.5))
    window.addCurveToPoint(CGPointMake(282.11, 147.7), controlPoint1: CGPointMake(251.93, 77.5), controlPoint2: CGPointMake(282.11, 147.7))
    window.addCurveToPoint(CGPointMake(351.45, 163.06), controlPoint1: CGPointMake(282.11, 147.7), controlPoint2: CGPointMake(331.96, 144.12))
    window.addCurveToPoint(CGPointMake(366.07, 222.58), controlPoint1: CGPointMake(370.94, 182), controlPoint2: CGPointMake(366.07, 222.58))
    window.addLineToPoint(CGPointMake(39.62, 222.58))
    window.addCurveToPoint(CGPointMake(54.24, 163.06), controlPoint1: CGPointMake(39.62, 222.58), controlPoint2: CGPointMake(37.18, 182))
    window.closePath()
    
    
    let wheel1 = UIBezierPath(ovalInRect: CGRectMake(86.5, 245.5, 70, 66))
    let wheel2 = UIBezierPath(ovalInRect: CGRectMake(244.5, 245.5, 70, 66))
    
    //// Bezier 2 Drawing
    let carBody = UIBezierPath()
    carBody.moveToPoint(CGPointMake(188.8, 96.22))
    carBody.addLineToPoint(CGPointMake(188.8, 147.7))
    carBody.addLineToPoint(CGPointMake(258.78, 147.7))
    carBody.addCurveToPoint(CGPointMake(235.46, 114.94), controlPoint1: CGPointMake(258.78, 147.7), controlPoint2: CGPointMake(252.95, 127.81))
    carBody.addCurveToPoint(CGPointMake(188.8, 96.22), controlPoint1: CGPointMake(217.96, 102.07), controlPoint2: CGPointMake(188.8, 96.22))
    
    let path = UIBezierPath()
    path.appendPath(window)
    path.appendPath(wheel1)
    path.appendPath(wheel2)
    path.appendPath(carBody)
    
    UIGraphicsEndImageContext()
    return path
  }
  
  
  class func drawUtilitiesIcon() -> UIBezierPath {
    
    UIGraphicsBeginImageContextWithOptions(drawingSize, false, 0.0)
    
    let path = UIBezierPath()
    path.moveToPoint(CGPointMake(290, 29))
    path.addLineToPoint(CGPointMake(76, 146))
    path.addLineToPoint(CGPointMake(224, 203))
    path.addLineToPoint(CGPointMake(132, 361))
    path.addLineToPoint(CGPointMake(316, 187))
    path.addLineToPoint(CGPointMake(193, 131))
    path.addLineToPoint(CGPointMake(290, 29))
    path.closePath()
    
    UIGraphicsEndImageContext()
    return path
  }
  
  class func drawFunIcon() -> UIBezierPath {
    UIGraphicsBeginImageContextWithOptions(drawingSize, false, 0.0)
    
    let outerCircle = UIBezierPath(ovalInRect: CGRect(x: 46, y: 46, width: 310, height: 310))
    let eye1 = UIBezierPath(ovalInRect: CGRect(x: 138, y: 126, width: 36, height: 72))
    let eye2 = UIBezierPath(ovalInRect: CGRect(x: 223, y: 126, width: 36, height: 72))
    let mouth = UIBezierPath()
    mouth.moveToPoint(CGPoint(x: 135, y: 250))
    mouth.addLineToPoint(CGPoint(x: 265, y: 250))
    mouth.addCurveToPoint(CGPoint(x: 135, y: 250), controlPoint1: CGPoint(x: 240, y: 300), controlPoint2: CGPoint(x: 150, y: 300))
    
    let path = UIBezierPath()
    path.appendPath(outerCircle)
    path.appendPath(eye1)
    path.appendPath(eye2)
    path.appendPath(mouth)
    
    UIGraphicsEndImageContext()
    return path
  }
  
  class func drawGroceriesIcon() -> UIBezierPath {
    
    UIGraphicsBeginImageContextWithOptions(drawingSize, false, 0.0)
    
    let basket = UIBezierPath()
    basket.moveToPoint(CGPointMake(36, 102))
    basket.addLineToPoint(CGPointMake(321, 102))
    basket.addLineToPoint(CGPointMake(337, 40))
    basket.addLineToPoint(CGPointMake(368, 25))
    
    basket.moveToPoint(CGPointMake(41, 102))
    basket.addLineToPoint(CGPointMake(88, 226))
    basket.addLineToPoint(CGPointMake(280, 241))
    basket.addLineToPoint(CGPointMake(321, 102))
    
    //// Wheels
    let wheel1 = UIBezierPath(ovalInRect: CGRectMake(88, 305, 58, 58))
    let wheel2 = UIBezierPath(ovalInRect: CGRectMake(240, 305, 58, 58))
    
    
    //// Bezier 3 Drawing
    let cartBase = UIBezierPath()
    cartBase.moveToPoint(CGPointMake(280, 249))
    cartBase.addCurveToPoint(CGPointMake(327, 269),
      controlPoint1: CGPointMake(280, 249),
      controlPoint2: CGPointMake(327, 233))
    cartBase.addCurveToPoint(CGPointMake(295, 290),
      controlPoint1: CGPointMake(327, 306), controlPoint2: CGPointMake(295, 290))
    cartBase.addLineToPoint(CGPointMake(72, 290))
    
    let path = UIBezierPath()
    path.appendPath(basket)
    path.appendPath(wheel1)
    path.appendPath(wheel2)
    path.appendPath(cartBase)
    
    UIGraphicsEndImageContext()
    
    return path
  }
  
  
  
  class func drawPetIcon() -> UIBezierPath {
    UIGraphicsBeginImageContextWithOptions(drawingSize, false, 0.0)
    
    let paw1 = UIBezierPath(ovalInRect: CGRect(x: 130, y: 174, width: 140, height: 154))
    let paw2 = UIBezierPath(ovalInRect: CGRect(x: 71, y: 104, width: 71, height: 89))
    let paw3 = UIBezierPath(ovalInRect: CGRect(x: 161, y: 66, width: 71, height: 89))
    let paw4 = UIBezierPath(ovalInRect: CGRect(x: 254, y: 104, width: 71, height: 89))
    let path = UIBezierPath()
    path.appendPath(paw1)
    path.appendPath(paw2)
    path.appendPath(paw3)
    path.appendPath(paw4)
    
    UIGraphicsEndImageContext()
    return path
  }
  
  class func drawMiscIcon() -> UIBezierPath {
    
    UIGraphicsBeginImageContextWithOptions(drawingSize, false, 0.0)
    
    let query = UIBezierPath()
    query.moveToPoint(CGPointMake(128, 107))
    query.addCurveToPoint(CGPointMake(192, 37), controlPoint1: CGPointMake(128.5, 107.06), controlPoint2: CGPointMake(133.45, 37.5))
    query.addCurveToPoint(CGPointMake(272, 121.96), controlPoint1: CGPointMake(252.21, 37.5), controlPoint2: CGPointMake(281.9, 77.25))
    query.addCurveToPoint(CGPointMake(192.83, 201.45), controlPoint1: CGPointMake(262.11, 166.67), controlPoint2: CGPointMake(192.83, 201.45))
    query.addLineToPoint(CGPointMake(192.83, 295.85))
    
    let queryDot = UIBezierPath(ovalInRect: CGRectMake(177.5, 320.5, 30, 30))
    
    let path = UIBezierPath()
    path.appendPath(query)
    path.appendPath(queryDot)
    
    UIGraphicsEndImageContext()
    return path
  }
  
  
}