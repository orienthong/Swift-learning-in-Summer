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
class CategoryCell: UICollectionViewCell {
  
  @IBOutlet var imageView: UIImageView!
  
  var category: Category?
  

  @IBInspectable var lineWidth:CGFloat = 2
  
  override func drawRect(rect: CGRect) {
    
    if selected {
      appRedColor.setStroke()
    } else {
      UIColor.blackColor().setStroke()
      
     }
    
    let edge = UIBezierPath(roundedRect: rect.insetBy(dx: lineWidth/2, dy: lineWidth/2), cornerRadius: 10)
    edge.lineWidth = lineWidth
    edge.stroke()
    
    
    guard let path = category?.iconPath else {return}
    
    scalePath(path, size: rect.size)
    
    path.lineWidth = lineWidth
    path.stroke()
    
    if !selected {
      let context = UIGraphicsGetCurrentContext()
      CGContextSetBlendMode(context, .SourceIn)
      
      let endPoint = CGPoint(x: 0, y: rect.height)
      
      drawGradient(cellGradientStart,
        endColor: cellGradientEnd,
        startPoint: .zero,
        endPoint: endPoint)
    }
  }
  
  private func scalePath(path:UIBezierPath, size:CGSize) {
    // scale path - icons should all be same height
    let scale = size.height / path.bounds.size.height * 0.5
    path.applyTransform(CGAffineTransformMakeScale(scale, scale))
    
    // move path to origin
    path.applyTransform(CGAffineTransformMakeTranslation(-path.bounds.origin.x, -path.bounds.origin.y))
    // move path into center
    path.applyTransform(CGAffineTransformMakeTranslation(size.width/2 - path.bounds.width/2, size.height/2 - path.bounds.height/2))
  }
}