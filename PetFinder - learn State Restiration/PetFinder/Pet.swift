//
//  Pet.swift
//  PetFinder
//
//  Created by Luke Parham on 8/31/15.
//  Copyright © 2015 Luke Parham. All rights reserved.
//

import Foundation
import UIKit

class Pet: NSObject {
  
  var name = ""
  var age = 0
  var imageData = NSData()
  var id = 0
  
  var imageURL = NSURL()
  
  override init() {
    super.init()
    imageURL = Pet.randomPetURL()
  }
  
  required convenience init(coder decoder: NSCoder) {
    self.init()
    
    if let archivedName = decoder.decodeObjectForKey("name") as? String {
      name = archivedName
    }
    
    if let archivedAge = decoder.decodeObjectForKey("age") as? Int {
      age = archivedAge
    }
    
    if let archivedImage = decoder.decodeObjectForKey("image") {
      imageData = archivedImage as! NSData
    }
    
    id = decoder.decodeIntegerForKey("id")
  }
  
  class func randomPet() -> Pet {
    let pet = Pet()
    
    pet.name = randomName()
    pet.age = randomAge()
    
    return pet
  }
  
  private class func randomName() -> String {
    return PetNameGenerator.randomName()
  }
  
  private class func randomAge() -> Int {
    return Int(arc4random_uniform(10)) + 1
  }
  
  private class func randomPetURL() -> NSURL {
    let width = Int(arc4random_uniform(500)) + 200
    let height = Int(arc4random_uniform(500)) + 200
    
    return NSURL(string: "https://placekitten.com/\(width)/\(height)")!
  }
  
}

extension Pet: NSCoding {
  
  func encodeWithCoder(coder: NSCoder) {
    coder.encodeObject(name, forKey: "name")
    coder.encodeObject(age, forKey: "age")
    coder.encodeObject(imageData, forKey: "image")
    coder.encodeInteger(id, forKey: "id")
  }
  
}