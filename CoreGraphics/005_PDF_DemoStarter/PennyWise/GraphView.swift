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

class GraphView: UIView {
  let chartColors = [
    UIColor(red: 1.0, green: 107/255, blue: 107/255, alpha: 1.0),
    UIColor(red: 155/255, green: 224/255, blue: 172/255, alpha: 1.0),
    UIColor(red: 136/255, green: 161/255, blue: 212/255, alpha: 1.0),
    UIColor(red: 1.0, green: 172/255, blue: 99/255, alpha: 1.0),
    UIColor(red: 135/255, green: 218/255, blue: 230/255, alpha: 1.0),
    UIColor(red: 250/255, green: 250/255, blue: 147/255, alpha: 1.0)]

  override func drawRect(rect:CGRect) {
    
    
    
    
    let context = UIGraphicsGetCurrentContext()
    
    let totalSpent = categories.reduce(0,
      combine: {$0 + $1.spent})
    guard totalSpent > 0 else { return }
    
    let diameter = min(bounds.width, bounds.height)
    let margin:CGFloat = 20
    
    let circle = UIBezierPath(ovalInRect:
      CGRect(x:0, y:0,
        width:diameter,
        height:diameter
        ).insetBy(dx: margin, dy: margin))
    
    let transform = CGAffineTransformMakeTranslation(bounds.width/2 - diameter/2 ,0)
    
    circle.applyTransform(transform)
    
    CGContextSaveGState(context)
    
    CGContextScaleCTM(context, 1, 0.6)
    CGContextTranslateCTM(context, 0, 100)
    
    
    let shadowColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.4)
    CGContextSetShadowWithColor(context,
      CGSize(width: 10, height: 10),
              1,
              shadowColor.CGColor)
    
    CGContextBeginTransparencyLayer(context, nil)
    
    let workingCategories = categories.filter({ $0.spent > 0 })
    
    for (index, _) in workingCategories.enumerate() {
    
      let percent = CGFloat(workingCategories[index].spent/totalSpent)
      let angle = percent * 2 * π
      
      print(workingCategories[index].name, workingCategories[index].spent, round(percent * 100))
      
      let slice = UIBezierPath()
      
      let radius = diameter / 2 - margin
      let centerPoint = center
      
      slice.moveToPoint(centerPoint)
      slice.addLineToPoint(CGPoint(x:centerPoint.x + radius, y:centerPoint.y))
      slice.addArcWithCenter(centerPoint, radius:radius, startAngle: 0, endAngle: angle, clockwise: true)
      slice.closePath()
      
      chartColors[index].setFill()
      slice.fill()
      
      drawText(workingCategories[index].name, centerPoint: centerPoint, radius:radius, angle:angle)

      
      CGContextTranslateCTM(context, centerPoint.x, centerPoint.y)
      CGContextRotateCTM(context, angle)
      CGContextTranslateCTM(context, -centerPoint.x, -centerPoint.y)
      
    }
    circle.stroke()
    
    CGContextEndTransparencyLayer(context)
    CGContextRestoreGState(context)
    
    
  }
  
  func drawText(name: String, centerPoint:CGPoint, radius:CGFloat, angle:CGFloat) {
  
    let context = UIGraphicsGetCurrentContext()

    CGContextSaveGState(context)

    CGContextTranslateCTM(context, centerPoint.x, centerPoint.y)
    CGContextRotateCTM(context, angle/2)
    CGContextTranslateCTM(context, -centerPoint.x, -centerPoint.y)

    
    let font = UIFont(name: "HelveticaNeue-Bold", size: 18)!
    let attributes = [NSFontAttributeName: font,
      NSForegroundColorAttributeName: UIColor.whiteColor()]
    

    let transform = CGContextGetCTM(context)
    let radians = atan2(transform.b, transform.a)
    if abs(radians) > π / 2 && abs(radians) < 3 / 2 * π {

      let textBounds = name.sizeWithAttributes(attributes)

      CGContextSaveGState(context)
      CGContextRotateCTM(context, π)
      
      name.drawAtPoint(CGPoint(x:-centerPoint.x - radius - textBounds.width - 10, y:-centerPoint.y), withAttributes:attributes)
      
      CGContextRestoreGState(context)


    } else {
      name.drawAtPoint(CGPoint(x:centerPoint.x + radius + 10, y:centerPoint.y), withAttributes:attributes)
    }
    
    CGContextRestoreGState(context)

  }
  
  func drawKey(categories: [Category], rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()
    
    let font = UIFont(name: "HelveticaNeue-Bold", size: 14)!
    let attributes = [NSFontAttributeName: font,
      NSForegroundColorAttributeName:
                                     UIColor.whiteColor()]
    let boxSize: CGFloat = 15
    let margin: CGFloat = 12
    
    var row: CGFloat = 0
    
    var largestWidth: CGFloat = 0
    for category in categories {
        let textBounds = category.name.sizeWithAttributes(attributes)
      if textBounds.width > largestWidth {
            largestWidth = textBounds.width
      }
    }
    
    CGContextSaveGState(context)
    
    let offsetX = rect.width - largestWidth - margin - boxSize - margin
    
    let totalHeight = CGFloat(categories.count) * (margin + boxSize)
    let offsetY = rect.height/2 - totalHeight/2
    
    
    CGContextTranslateCTM(context, offsetX, offsetY)
    
    
    for (index, category) in categories.enumerate() {
      
      UIColor.blackColor().setStroke()
      
      let box = UIBezierPath(rect: CGRect(x: 0, y: row,
        width: boxSize, height: boxSize))
      chartColors[index].setFill()
      box.fill()
      box.lineWidth = 1
      box.stroke()
      
      let point = CGPoint(x: boxSize + margin, y: row)
      category.name.drawAtPoint(point, withAttributes: attributes)
      
      
      
      row += boxSize + margin
      
    }
    
    CGContextRestoreGState(context)
    
    
  }
  
  func drawImage() -> UIImage {
    
    let rect = CGRect(x: 0, y: 0, width: 20, height: 20)
    UIGraphicsBeginImageContextWithOptions(rect.size, true, 0.0)
    
    darkViewColor.setFill()
    UIRectFill(rect)
    
let context = UIGraphicsGetCurrentContext()
    CGContextSetAlpha(context, 0.5)
    lightViewColor.setFill()
    UIBezierPath(rect: rect.insetBy(dx: 0, dy: 9)).fill()
    
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
    
  }
  
  
}

