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

class Category: Equatable {
  var name:String
  var budget:Float
  var spent: Float
  lazy var iconPath:UIBezierPath? = drawIcon(self)()

  lazy var image: UIImage? = {
    UIImage(named: "Icon" + self.name)
  }()
  
  init(name:String, budget:Float, spent:Float) {
    self.name = name
    self.budget = budget
    self.spent = spent
  }
  
  func drawIcon() -> UIBezierPath? {
    var path:UIBezierPath?
    switch name {
    case "Auto":
      path = DrawIcon.drawAutoIcon()
    case "Utilities":
      path = DrawIcon.drawUtilitiesIcon()
    case "Fun":
      path = DrawIcon.drawFunIcon()
    case "Groceries":
      path = DrawIcon.drawGroceriesIcon()
    case "Pet":
      path = DrawIcon.drawPetIcon()
    case "Misc":
      path = DrawIcon.drawMiscIcon()
    default:()
    }
    return path
  }
}

func == (lhs:Category, rhs:Category) -> Bool {
  return lhs.name == rhs.name &&
         lhs.budget == rhs.budget &&
         lhs.spent == rhs.spent
}

let categories = [
  Category(name: "Auto", budget: 2000, spent: 1200),
  Category(name: "Utilities", budget: 400, spent: 600),
  Category(name: "Fun", budget: 1200, spent: 1000),
  Category(name: "Groceries", budget: 600, spent: 800),
  Category(name: "Pet", budget: 200, spent: 100),
  Category(name: "Misc", budget: 800, spent: 400)
]




