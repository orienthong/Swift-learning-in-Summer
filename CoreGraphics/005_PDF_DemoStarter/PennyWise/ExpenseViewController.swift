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

protocol ExpenseViewControllerDelegate {
  func expenseViewController(expenseViewController:ExpenseViewController,
    didExpenseCategory category:Category?, amount:Float)
}

class ExpenseViewController: UIViewController {
  
  @IBOutlet weak var resultLabel: UILabel!
  @IBOutlet var numberViews: [NumberView]!
  @IBOutlet var decimalView: NumberView!
  @IBOutlet var backspaceView: NumberView!
  @IBOutlet var btnDone: UIButton!
  
  private let cellMargin:CGFloat = 10
  
  private let backspace:Int = 99
  private let decimalPoint = 98

  var delegate: ExpenseViewControllerDelegate?
  
  var selectedCategory: Category?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Set up numbers for numeric keyboard
    for (index, numberView) in numberViews.enumerate() {
      numberView.number = index
      numberView.delegate = self
    }
    decimalView.number = decimalPoint
    decimalView.label = "."
    decimalView.delegate = self
    backspaceView.number = backspace
    backspaceView.label = "↩︎"
    backspaceView.delegate = self
    
  }
  
  @IBAction func btnDone(sender: UIButton) {
    var spent:Float = 0
    if let text = resultLabel.text {
      let numericText = String(text.characters.dropFirst())
      spent = (numericText as NSString).floatValue
    }
    delegate?.expenseViewController(self, didExpenseCategory:
      selectedCategory, amount:spent)
  }
  
  func setBtnDone(enabled enabled:Bool) {
    btnDone.enabled = enabled
    if btnDone.enabled {
      btnDone.backgroundColor = buttonEnabledColor
    }
  }
  
  override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
    return [.Portrait, .PortraitUpsideDown]
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "EmbedCategoryViewController" {
      if let controller = segue.destinationViewController as? CategoryViewController {
        controller.collectionView?.delegate = self
      }
    }
  }
}

extension ExpenseViewController: NumberViewDelegate {
  
  func numberTapped(number:Int) {
    var text = resultLabel.text ?? "$0"
    guard text.characters.count > 1 else { return }
    
    // drop off $ sign
    text = String(text.characters.dropFirst())
    let maxLength = 10
    switch number {
    case backspace:
      text = String(text.characters.dropLast())
      if text.characters.count == 0 {
        text = "0"
      }
    case decimalPoint where text.characters.count < maxLength:
      // add decimal point if one does not exist already
      let elements = text.characters.filter { $0 == "." }
      if elements.count == 0 {
        text = text + "."
      }
    default:
      if text.characters.count < maxLength {
        text = text + "\(number)"
        
        // drop front 0 if no decimal place involved
        let elements = text.characters.filter { $0 == "." }
        if elements.count == 0 {
          if text.characters.first == "0" {
            text = String(text.characters.dropFirst())
          }
        }
      }
    }
    resultLabel.text = "$" + text
  }
}

extension ExpenseViewController: UICollectionViewDelegate {

  func collectionView(collectionView: UICollectionView,
                willDisplayCell cell: UICollectionViewCell,
                forItemAtIndexPath indexPath: NSIndexPath) {
    if let cell = cell as? CategoryCell {
      if cell.category?.name == selectedCategory?.name {
        collectionView.selectItemAtIndexPath(indexPath, animated: true,
          scrollPosition: .None)
        cell.selected = true
        cell.setNeedsDisplay()
        setBtnDone(enabled: true)
      }
    }
  }
  
  func collectionView(collectionView: UICollectionView,
                didDeselectItemAtIndexPath indexPath: NSIndexPath) {
    let cell = collectionView.cellForItemAtIndexPath(indexPath)
    cell?.setNeedsDisplay()
  }
  
  func collectionView(collectionView: UICollectionView,
                didSelectItemAtIndexPath indexPath: NSIndexPath) {
    selectedCategory = categories[indexPath.row]
    let cell = collectionView.cellForItemAtIndexPath(indexPath)
                  
    cell?.setNeedsDisplay()
    setBtnDone(enabled: true)
  }
}

extension ExpenseViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(collectionView: UICollectionView,
          layout collectionViewLayout:UICollectionViewLayout,
          minimumInteritemSpacingForSectionAtIndex section:Int) -> CGFloat {
    return cellMargin
  }
  
  func collectionView(collectionView : UICollectionView,
          layout collectionViewLayout:UICollectionViewLayout,
          sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize
  {
    // Ensure that there are three columns no
    // matter what device
    let size = collectionView.bounds.height / 2 - cellMargin
    let width = (collectionView.bounds.width - (cellMargin * 3)) / 3
    if width < size {
      return CGSize(width: width, height: width)
    }
    return CGSize(width: size, height: size)
  }
}

