//
//  AppDelegate.swift
//  Camera Roll
//
//  Created by Mic Pringle on 18/03/2015.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    return true
  }
    func application(application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return true
    }
    func application(application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return true
    }
    

}

