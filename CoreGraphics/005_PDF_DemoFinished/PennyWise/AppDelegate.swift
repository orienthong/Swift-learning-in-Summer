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

// Globals
let π = CGFloat(M_PI)

let lightViewColor = UIColor(red: 165/255, green: 193/255, blue: 207/255, alpha: 1.0)
let darkViewColor = UIColor(red: 145/255, green: 175/255, blue: 191/255, alpha: 1.0)

let darkTextColor = UIColor(red: 79/255, green: 92/255, blue: 105/255, alpha: 1.0)
let cellSelectedColor = UIColor(red: 79/255, green: 92/255, blue: 105/255, alpha: 1.0)
let buttonEnabledColor = UIColor(red: 246/255, green: 158/255, blue: 81/255, alpha: 1.0)

let appGreenColor = UIColor(red: 146/255, green: 203/255, blue: 149/255, alpha: 1.0)
let appOrangeColor = UIColor(red: 249/255, green: 158/255, blue: 78/255, alpha: 1.0)
let appRedColor = UIColor(red: 1.0, green: 107/255, blue: 107/255, alpha: 1.0)

let cellGradientStart = UIColor(red: 94/255, green: 219/255, blue: 159/255, alpha: 1.0)
let cellGradientEnd = UIColor(red: 171/255, green: 227/255, blue: 1.0, alpha: 1.0)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    configureAppearance()
    return true
  }
  
  func configureAppearance() {
    UINavigationBar.appearance().barTintColor = lightViewColor
    UINavigationBar.appearance().translucent = false
    UIBarButtonItem.appearance().tintColor = UIColor.whiteColor()

    // sets the status bar light
    UINavigationBar.appearance().barStyle = .Black
  }
}

