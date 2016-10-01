//
//  Extensions.swift
//  PetFinder
//
//  Created by Luke Parham on 8/31/15.
//  Copyright © 2015 Luke Parham. All rights reserved.
//

import UIKit

extension UIImageView {
  
  func loadURL(url: NSURL?) {
    guard let url = url else {
      return
    }
    
    let urlRequest = NSURLRequest(URL: url)
    
    NSURLSession.sharedSession().dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
      if let response = response, data = data where response.isHTTPResponseValid() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
          if UIImage(data: data) == nil {
            self.image = UIImage(named: "standardCat")
          } else {
            self.image = UIImage(data: data)
          }
        })
      }
      }.resume()
  }
  
}

extension NSURLResponse {
  func isHTTPResponseValid() -> Bool {
    guard let response = self as? NSHTTPURLResponse else {
      return false
    }
    
    return (response.statusCode >= 200 && response.statusCode <= 299)
  }
}