//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

DataManager.getTopAppsDataFromItunesWithSuccess{
    (data) -> Void in
    var json: [String: AnyObject]!
    do {
        json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String: AnyObject]
    } catch {
        print(error)
        XCPlaygroundPage.currentPage.finishExecution()
    }
    guard let topApps = TopApps(json: json) else {
        print("error")
        XCPlaygroundPage.currentPage.finishExecution()
    }
    guard let firstItem = topApps.feed?.entries?.first else {
        XCPlaygroundPage.currentPage.finishExecution()
    }
    print(firstItem)
    
    XCPlaygroundPage.currentPage.finishExecution()
    
}