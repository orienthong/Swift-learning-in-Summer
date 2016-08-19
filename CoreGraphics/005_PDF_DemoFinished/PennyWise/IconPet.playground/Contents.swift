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

let paw1 = UIBezierPath(ovalInRect: CGRect(x: 130, y: 174, width: 140, height: 154))
paw1.lineWidth = lineWidth
paw1.stroke()

let paw2 = UIBezierPath(ovalInRect: CGRect(x: 71, y: 104, width: 71, height: 89))
paw2.lineWidth = lineWidth
paw2.stroke()

let paw3 = UIBezierPath(ovalInRect: CGRect(x: 161, y: 66, width: 71, height: 89))
paw3.lineWidth = lineWidth
paw3.stroke()

let paw4 = UIBezierPath(ovalInRect: CGRect(x: 254, y: 104, width: 71, height: 89))
paw4.lineWidth = lineWidth
paw4.stroke()

let path = UIBezierPath()
path.appendPath(paw1)
path.appendPath(paw2)
path.appendPath(paw3)
path.appendPath(paw4)



let image = UIGraphicsGetImageFromCurrentImageContext()
UIGraphicsEndImageContext()
image


UIGraphicsBeginImageContextWithOptions(size, false, 0)

path.stroke()

let image2 = UIGraphicsGetImageFromCurrentImageContext()
UIGraphicsEndImageContext()
image2

