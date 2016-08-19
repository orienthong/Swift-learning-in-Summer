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

class PDFViewController: UIViewController {
  
  @IBOutlet var webView: UIWebView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Create the pdf
    createPDF()

    // Load the pdf file in a UIWebView
    if let url = documentPath() {
      webView.loadRequest(NSURLRequest(URL: url))
    }
  }
  
  // Document Directory URL
  private func documentPath() -> NSURL? {
    let fileManager = NSFileManager.defaultManager()
    let documentsUrl = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0] as NSURL
    return documentsUrl.URLByAppendingPathComponent("PennyWise.pdf")
  }
  
  private func createPDF() {
    // Create PDF
    // set the default page size to 8.5 by 11 inches
    // (612 by 792 points).
    
    guard let pdfPath = documentPath()?.path else { return }
    
    UIGraphicsBeginPDFContextToFile(pdfPath, .zero, nil)
    
    UIGraphicsBeginPDFPage()
    renderBackground()
    
    renderCategories()
    
    UIGraphicsEndPDFContext()
    
  }
  
  func renderBackground() {
    guard let context = UIGraphicsGetCurrentContext() else { return }
    
    let rect = CGContextGetClipBoundingBox(context)
    lightViewColor.setFill()
    UIRectFill(rect)
    
  }
  
  func renderCategories() {
    guard let context = UIGraphicsGetCurrentContext() else { return }
    
    guard let budgetController = storyboard?.instantiateViewControllerWithIdentifier("BudgetTableViewController") as? BudgetTableViewController else {  return }
    
    let width = budgetController.tableView.contentSize.width
    let height = budgetController.tableView.rowHeight * CGFloat(categories.count)
    
    let frame = CGRect(origin: .zero, size: CGSize(width: width, height: height))
    budgetController.tableView.frame = frame
    
    CGContextSaveGState(context)
    
    let rect = CGContextGetClipBoundingBox(context)
    
    CGContextTranslateCTM(context,
                (rect.width - width)  / 2,
                (rect.height - height) / 2)
    
    
    budgetController.tableView.layer.renderInContext(context)
    
    CGContextRestoreGState(context)
    
    let attributes = [NSFontAttributeName: UIFont.boldSystemFontOfSize(36),
      NSForegroundColorAttributeName: UIColor.whiteColor()]
    
    let title = "PennyWise Budget"
    title.drawAtPoint(CGPoint(x: 32, y: 40), withAttributes: attributes)
    
  }
  

}


