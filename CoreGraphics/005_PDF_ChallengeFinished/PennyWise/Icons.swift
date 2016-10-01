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

public class Icons : NSObject {

    //// Drawing Methods

    public class func drawAutoIcon(frame frame: CGRect = CGRectMake(0, 0, 400, 400), isSelected: Bool = true) {
        //// Color Declarations
        let color = UIColor(red: 1.000, green: 0.984, blue: 0.306, alpha: 1.000)
        let selectedColor = UIColor(red: 0.963, green: 0.000, blue: 0.000, alpha: 1.000)
        let unselectedColor = UIColor(red: 0.000, green: 1.000, blue: 0.211, alpha: 1.000)

        //// Variable Declarations
        let selectColor = isSelected ? selectedColor : unselectedColor


        //// Subframes
        let group: CGRect = CGRectMake(frame.minX + floor(frame.width * 0.05490 - 0.46) + 0.96, frame.minY + floor(frame.height * 0.13875 + 0.5), floor(frame.width * 0.96703 - 0.31) - floor(frame.width * 0.05490 - 0.46) - 0.15, floor(frame.height * 0.87000) - floor(frame.height * 0.13875 + 0.5) + 0.5)


        //// Group
        //// Wheel 1 Drawing
        let wheel1Path = UIBezierPath(ovalInRect: CGRectMake(group.minX + floor(group.width * 0.11934 - 0.04) + 0.54, group.minY + floor(group.height * 0.71795) + 0.5, floor(group.width * 0.35231 - 0.04) - floor(group.width * 0.11934 - 0.04), floor(group.height * 0.99829) - floor(group.height * 0.71795)))
        UIColor.lightGrayColor().setFill()
        wheel1Path.fill()
        selectColor.setStroke()
        wheel1Path.lineWidth = 2
        wheel1Path.stroke()


        //// Wheel 2 Drawing
        let wheel2Path = UIBezierPath(ovalInRect: CGRectMake(group.minX + floor(group.width * 0.58254 - 0.04) + 0.54, group.minY + floor(group.height * 0.71966 + 0.5), floor(group.width * 0.81277 - 0.04) - floor(group.width * 0.58254 - 0.04), floor(group.height * 1.00000 + 0.5) - floor(group.height * 0.71966 + 0.5)))
        UIColor.lightGrayColor().setFill()
        wheel2Path.fill()
        selectColor.setStroke()
        wheel2Path.lineWidth = 2
        wheel2Path.stroke()


        //// Car Body Drawing
        let carBodyPath = UIBezierPath()
        carBodyPath.moveToPoint(CGPointMake(group.minX + 0.00189 * group.width, group.minY + 0.64968 * group.height))
        carBodyPath.addCurveToPoint(CGPointMake(group.minX + 0.07885 * group.width, group.minY + 0.43312 * group.height), controlPoint1: CGPointMake(group.minX + 0.00189 * group.width, group.minY + 0.64968 * group.height), controlPoint2: CGPointMake(group.minX + -0.01910 * group.width, group.minY + 0.53503 * group.height))
        carBodyPath.addCurveToPoint(CGPointMake(group.minX + 0.25377 * group.width, group.minY + 0.33970 * group.height), controlPoint1: CGPointMake(group.minX + 0.17680 * group.width, group.minY + 0.33121 * group.height), controlPoint2: CGPointMake(group.minX + 0.25377 * group.width, group.minY + 0.33970 * group.height))
        carBodyPath.addCurveToPoint(CGPointMake(group.minX + 0.48116 * group.width, group.minY + -0.00000 * group.height), controlPoint1: CGPointMake(group.minX + 0.25377 * group.width, group.minY + 0.33970 * group.height), controlPoint2: CGPointMake(group.minX + 0.26776 * group.width, group.minY + -0.00000 * group.height))
        carBodyPath.addCurveToPoint(CGPointMake(group.minX + 0.72254 * group.width, group.minY + 0.33970 * group.height), controlPoint1: CGPointMake(group.minX + 0.69455 * group.width, group.minY + -0.00000 * group.height), controlPoint2: CGPointMake(group.minX + 0.72254 * group.width, group.minY + 0.33970 * group.height))
        carBodyPath.addCurveToPoint(CGPointMake(group.minX + 0.91145 * group.width, group.minY + 0.43312 * group.height), controlPoint1: CGPointMake(group.minX + 0.72254 * group.width, group.minY + 0.33970 * group.height), controlPoint2: CGPointMake(group.minX + 0.80650 * group.width, group.minY + 0.29299 * group.height))
        carBodyPath.addCurveToPoint(CGPointMake(group.minX + 0.99891 * group.width, group.minY + 0.64968 * group.height), controlPoint1: CGPointMake(group.minX + 1.01640 * group.width, group.minY + 0.57325 * group.height), controlPoint2: CGPointMake(group.minX + 0.99891 * group.width, group.minY + 0.64968 * group.height))
        carBodyPath.addLineToPoint(CGPointMake(group.minX + 0.00189 * group.width, group.minY + 0.64968 * group.height))
        carBodyPath.closePath()
        color.setFill()
        carBodyPath.fill()
        selectColor.setStroke()
        carBodyPath.lineWidth = 2
        carBodyPath.stroke()


        //// Car Window Drawing
        let carWindowPath = UIBezierPath()
        carWindowPath.moveToPoint(CGPointMake(group.minX + 0.50215 * group.width, group.minY + 0.11040 * group.height))
        carWindowPath.addLineToPoint(CGPointMake(group.minX + 0.50215 * group.width, group.minY + 0.32272 * group.height))
        carWindowPath.addLineToPoint(CGPointMake(group.minX + 0.65607 * group.width, group.minY + 0.32272 * group.height))
        carWindowPath.addCurveToPoint(CGPointMake(group.minX + 0.60010 * group.width, group.minY + 0.18259 * group.height), controlPoint1: CGPointMake(group.minX + 0.65607 * group.width, group.minY + 0.32272 * group.height), controlPoint2: CGPointMake(group.minX + 0.64908 * group.width, group.minY + 0.23355 * group.height))
        carWindowPath.addCurveToPoint(CGPointMake(group.minX + 0.50215 * group.width, group.minY + 0.11040 * group.height), controlPoint1: CGPointMake(group.minX + 0.55112 * group.width, group.minY + 0.13163 * group.height), controlPoint2: CGPointMake(group.minX + 0.50215 * group.width, group.minY + 0.11040 * group.height))
        carWindowPath.closePath()
        UIColor.whiteColor().setFill()
        carWindowPath.fill()
        selectColor.setStroke()
        carWindowPath.lineWidth = 1
        carWindowPath.stroke()
    }

    public class func drawMiscIcon(frame frame: CGRect = CGRectMake(0, 0, 400, 400), isSelected: Bool = true) {
        //// Color Declarations
        let selectedColor = UIColor(red: 0.963, green: 0.000, blue: 0.000, alpha: 1.000)
        let unselectedColor = UIColor(red: 0.000, green: 1.000, blue: 0.211, alpha: 1.000)

        //// Variable Declarations
        let selectColor = isSelected ? selectedColor : unselectedColor

        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(frame.minX + 0.33875 * frame.width, frame.minY + 0.17375 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.49375 * frame.width, frame.minY + 0.07125 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.33875 * frame.width, frame.minY + 0.17375 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.35375 * frame.width, frame.minY + 0.07125 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.66125 * frame.width, frame.minY + 0.26375 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.63375 * frame.width, frame.minY + 0.07125 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.66125 * frame.width, frame.minY + 0.17375 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.49375 * frame.width, frame.minY + 0.47875 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.66125 * frame.width, frame.minY + 0.35375 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.49375 * frame.width, frame.minY + 0.44125 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.49375 * frame.width, frame.minY + 0.68375 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.49375 * frame.width, frame.minY + 0.51625 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.49375 * frame.width, frame.minY + 0.68375 * frame.height))
        selectColor.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()


        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(frame.minX + floor(frame.width * 0.44125) + 0.5, frame.minY + floor(frame.height * 0.75875) + 0.5, floor(frame.width * 0.56125) - floor(frame.width * 0.44125), floor(frame.height * 0.87875) - floor(frame.height * 0.75875)))
        selectColor.setStroke()
        ovalPath.lineWidth = 1
        ovalPath.stroke()
    }

}
