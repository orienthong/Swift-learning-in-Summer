//: Playground - noun: a place where people can play

import UIKit

let size = CGSize(width: 400, height: 400)
let rect = CGRect(origin: .zero, size: size)

let backgroundColor = UIColor.redColor()
let drawingColor = UIColor.blackColor()

let lineWidth:CGFloat = 5.0

UIGraphicsBeginImageContextWithOptions(size, false, 0.0)

let context = UIGraphicsGetCurrentContext()

let edge = UIBezierPath(roundedRect: rect.insetBy(dx: lineWidth/2, dy: lineWidth/2), cornerRadius: 50)

CGContextSaveGState(context)

  edge.addClip()


backgroundColor.setFill()
UIRectFill(rect)

CGContextRestoreGState(context)

edge.lineWidth = lineWidth
drawingColor.setStroke()
edge.stroke()

let outerCircle = UIBezierPath(ovalInRect: CGRect(x: 46, y: 46, width: 310, height: 310))
outerCircle.lineWidth = lineWidth
outerCircle.stroke()

let eye1 = UIBezierPath(ovalInRect: CGRect(x: 138, y: 126, width: 36, height: 72))
eye1.lineWidth = lineWidth
eye1.stroke()

let eye2 = UIBezierPath(ovalInRect: CGRect(x: 223, y: 126, width: 36, height: 72))
eye2.lineWidth = lineWidth
eye2.stroke()

let mouth = UIBezierPath()
mouth.lineWidth = lineWidth
mouth.moveToPoint(CGPoint(x: 136, y: 250))
mouth.addLineToPoint(CGPoint(x: 265, y: 250))
mouth.addCurveToPoint(CGPoint(x: 135, y: 250),
  controlPoint1: CGPoint(x: 240, y: 300),
  controlPoint2: CGPoint(x: 150, y: 300))
mouth.closePath()
mouth.lineJoinStyle = .Round

mouth.stroke()

let path = UIBezierPath()
path.appendPath(outerCircle)
path.appendPath(eye1)
path.appendPath(eye2)
path.appendPath(mouth)

let image = UIGraphicsGetImageFromCurrentImageContext()
UIGraphicsEndImageContext()
image


UIGraphicsBeginImageContextWithOptions(size, false, 0.0)

path.stroke()

let image2 = UIGraphicsGetImageFromCurrentImageContext()
UIGraphicsEndImageContext()
image2

