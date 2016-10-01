//
//  PetNetworking.swift
//  PetFinder
//
//  Created by Luke Parham on 8/31/15.
//  Copyright © 2015 Luke Parham. All rights reserved.
//

import Foundation
import UIKit

class PetNetworking {
  class func fetchImageAtURL(url:String, success:(UIImage?) -> Void) {
    
    let urlRequest = NSURLRequest(URL: NSURL(string: url)!)
    
    NSURLSession.sharedSession().dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
      if let response = response, data = data where response.isHTTPResponseValid() {
        success(UIImage(data: data))
      }
    }
  }
}
