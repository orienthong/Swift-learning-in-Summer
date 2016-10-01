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


@objc protocol NumberViewDelegate {
  func numberTapped(number:Int)
}

@IBDesignable
class NumberView: UIView {
  
  @IBOutlet var delegate:NumberViewDelegate?
  

  var numberLabel:UILabel?
  var number: Int = 0 {
    didSet {
      numberLabel?.text = "\(number)"
    }
  }
  
  var label: String? {
    didSet {
      numberLabel?.text = label
    }
  }
  
  @IBInspectable var lineWidth:CGFloat = 2
  
  @IBInspectable var fillColor:UIColor = UIColor.redColor()
  @IBInspectable var strokeColor:UIColor = UIColor.blueColor()
  
  override func drawRect(rect: CGRect) {
    let insetRect = rect.insetBy(dx: lineWidth/2, dy: lineWidth/2)
    let path = UIBezierPath(ovalInRect: insetRect)
    path.lineWidth = lineWidth
    
    fillColor.setFill()
    path.fill()
    
    strokeColor.setStroke()
    path.stroke()
  }
  
  @IBAction func handleTap(gesture:UITapGestureRecognizer) {
    delegate?.numberTapped(number)
  }
  
  
  override func awakeFromNib() {
    setup()
  }
  
  override func prepareForInterfaceBuilder() {
    setup()
  }
  
  func setup() {
    numberLabel = UILabel(frame: bounds)
    guard let numberLabel = numberLabel else { return }
    numberLabel.textAlignment = .Center
    numberLabel.textColor = darkTextColor
    numberLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 32)
    numberLabel.text = "0"
    addSubview(numberLabel)

    numberLabel.translatesAutoresizingMaskIntoConstraints  = false
    numberLabel.topAnchor.constraintEqualToAnchor(topAnchor).active = true
    numberLabel.heightAnchor.constraintEqualToAnchor(heightAnchor).active = true
    numberLabel.leadingAnchor.constraintEqualToAnchor(leadingAnchor).active = true
    numberLabel.widthAnchor.constraintEqualToAnchor(widthAnchor).active = true
  }
  
  override func intrinsicContentSize() -> CGSize {
    return bounds.size
  }
  
}
