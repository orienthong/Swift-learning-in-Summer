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
class BudgetView: UIView {
  
  var percent:Float = 0.5 {
    didSet {
      setNeedsDisplay()
    }
  }
  
  @IBInspectable var percentLineColor:UIColor = appGreenColor
  @IBInspectable var percentWarningLineColor:UIColor = appOrangeColor
  @IBInspectable var percentDangerLineColor:UIColor = appRedColor
  
  @IBInspectable var lineWidth:CGFloat = 13
  
  override func drawRect(rect: CGRect) {
    let path = UIBezierPath()
    path.lineWidth = lineWidth
    
    path.moveToPoint(CGPoint(x: 0, y: round(rect.height/2) + 0.5))
    
    let end = rect.width * CGFloat(percent)
    path.addLineToPoint(CGPoint(x: end, y: round(rect.height/2)+0.5))
    
    path.lineCapStyle = .Round
    
    if percent >= 1.0 {
      percentDangerLineColor.setStroke()
    } else if percent > 0.8 {
      percentWarningLineColor.setStroke()
    } else {
      percentLineColor.setStroke()
    }
    
    path.stroke()
    
  }
  
}
