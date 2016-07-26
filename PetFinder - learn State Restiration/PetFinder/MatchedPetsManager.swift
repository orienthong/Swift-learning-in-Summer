//
//  MatchedPetsManager.swift
//  PetFinder
//
//  Created by Luke Parham on 9/1/15.
//  Copyright © 2015 Luke Parham. All rights reserved.
//

import UIKit

class MatchedPetsManager {
  
  static let sharedManager = MatchedPetsManager()
  
  private let fileName = "petArray"
  
  var matchedPets = [Pet]()
  
  init() {
    unarchivePets()
  }
  
  func addPet(pet: Pet) {
    matchedPets.insert(pet, atIndex: 0)
  }
  
  func unarchivePets() {
    let dirPath = NSSearchPathForDirectoriesInDomains(.LibraryDirectory, .UserDomainMask, true)[0] as String
    let pathArray = [dirPath, fileName]
    let fileURL =  NSURL.fileURLWithPathComponents(pathArray)!
    
    if let path = fileURL.path, pets = NSKeyedUnarchiver.unarchiveObjectWithFile(path) {
      matchedPets = pets as! [Pet]
    }
  }
  
  func archivePets() {
    let dirPath = NSSearchPathForDirectoriesInDomains(.LibraryDirectory, .UserDomainMask, true)[0] as String
    let pathArray = [dirPath, fileName]
    let fileURL =  NSURL.fileURLWithPathComponents(pathArray)!
    
    NSKeyedArchiver.archiveRootObject(matchedPets, toFile: fileURL.path!)
  }
  
  func updatePet(id id: Int, name: String?, age: String?) {
    guard let name = name, let age = Int(age ?? "0") else { return }
    
    for pet in matchedPets {
      if pet.id == id {
        pet.name = name
        pet.age  = age
      }
    }
  }
  
  func petForId(id: Int) -> Pet? {
    for pet in matchedPets {
      if pet.id == id {
        return pet
      }
    }
    
    return nil
  }
}
