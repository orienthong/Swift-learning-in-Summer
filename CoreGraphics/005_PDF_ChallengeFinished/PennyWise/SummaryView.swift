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

@IBDesignable
class SummaryView: UIView {

  var percentSpent:Float = 0.5 {
    didSet {
      rotatePointer()
    }
  }

  var lineWidth: CGFloat {
    return bounds.height / 4
  }
  
  var margin:CGFloat = 30
  
  private let pointerLayer = CAShapeLayer()
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    layer.addSublayer(pointerLayer)
  }
  
  func rotatePointer() {
    if percentSpent > 1 {
      percentSpent = 1
    }
    
    let transform = CGAffineTransformMakeRotation(-π/2 + π * CGFloat(percentSpent))

    pointerLayer.setAffineTransform(transform)
  }

  override func drawRect(rect: CGRect) {
    let arcCenter = CGPoint(x: rect.midX, y: rect.height - margin)
    let radius = rect.height - lineWidth/2 - margin*2
    
    let startAngle:CGFloat = π
    let endAngle:CGFloat = 0
    
    let path = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
    
    path.lineWidth = lineWidth

    guard let newCGPath = CGPathCreateCopyByStrokingPath(
              path.CGPath,
              nil,
              path.lineWidth,
              path.lineCapStyle,
              path.lineJoinStyle,
              path.miterLimit)
      else {return}
    
    let newPath = UIBezierPath(CGPath: newCGPath)
    UIColor.whiteColor().setFill()
    newPath.fill()
    
    newPath.addClip()
    
    drawGradient(appGreenColor,
      endColor: UIColor.whiteColor(),
      startPoint: CGPoint(x: 0, y: rect.height),
      endPoint: CGPoint(x: rect.midX, y: rect.midY))
    
    drawGradient(UIColor.whiteColor(),
      endColor:appRedColor,
      startPoint: CGPoint(x: rect.midX, y: rect.midY),
      endPoint: CGPoint(x: rect.width, y: rect.height))
    
    UIColor.lightGrayColor().setStroke()
    newPath.lineWidth = 2
    newPath.stroke()
    
  }
  

  override func layoutSubviews() {
    super.layoutSubviews()
    
    let path = createPointerPath()
    pointerLayer.path = path.CGPath
    pointerLayer.bounds = path.bounds
    pointerLayer.fillColor = darkViewColor.CGColor
    pointerLayer.anchorPoint = CGPoint(x: 0.5, y: 1)
    
    pointerLayer.position = CGPoint(x: bounds.midX, y: bounds.height-margin)
  }
  
  func createPointerPath() -> UIBezierPath {
    let pointerHeight = bounds.height - lineWidth - margin
    let pointerWidth:CGFloat = 18
    
    let pointerPath = UIBezierPath()

    pointerPath.moveToPoint(CGPoint(x:pointerWidth/2, y:0))
    
    pointerPath.addCurveToPoint(
      CGPoint(x: pointerWidth/2, y:pointerHeight),
      controlPoint1: CGPoint(x: pointerWidth/2, y: 0),
      controlPoint2: CGPoint(x: -pointerWidth, y: pointerHeight))

    pointerPath.addCurveToPoint(
      CGPoint(x: pointerWidth/2, y: 0),
      controlPoint1: CGPoint(x: pointerWidth*2, y: pointerHeight),
      controlPoint2: CGPoint(x: pointerWidth/2, y: 0))

    return pointerPath
    
  }
  
}
