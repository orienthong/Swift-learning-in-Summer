//
//  PetDetailsViewController.swift
//  PetFinder
//
//  Created by Luke Parham on 9/1/15.
//  Copyright © 2015 Luke Parham. All rights reserved.
//

import UIKit

class PetDetailsViewController: UIViewController {
  
  @IBOutlet weak var nameAgeLabel: UILabel!
  @IBOutlet weak var profilePictureImageView: UIImageView!
  
  var petId: Int?
  var currentPet: Pet?
  
  override func viewDidLoad() {
    profilePictureImageView.layer.cornerRadius = 4.0
    profilePictureImageView.layer.borderColor = UIColor.whiteColor().CGColor
    profilePictureImageView.layer.borderWidth = 2.0
    
    let editButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(PetDetailsViewController.editWasTapped(_:)))
    navigationItem.rightBarButtonItem = editButton
  }
  
  func editWasTapped(sender: AnyObject) {
    let vc = PetEditViewController()
    
    vc.petId = petId
    
    navigationController?.pushViewController(vc, animated: true)
  }
  
  override func viewWillAppear(animated: Bool) {
    guard let petId = petId, pet = MatchedPetsManager.sharedManager.petForId(petId) else {
      return
    }
    
    currentPet = pet
    setPet()
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }
  
  func setPet() {
    guard let currentPet = currentPet else {
      return
    }
    
    title = currentPet.name
    nameAgeLabel.text = "\(currentPet.name), \(currentPet.age)"
    profilePictureImageView.image = UIImage(data: currentPet.imageData)
  }
}
