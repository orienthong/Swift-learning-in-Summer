//
//  FirstViewController.swift
//  PetFinder
//
//  Created by Luke Parham on 8/31/15.
//  Copyright © 2015 Luke Parham. All rights reserved.
//

import UIKit

class IntroductionViewController: UIViewController {
  
  @IBOutlet weak var petProfileView: UIView!
  @IBOutlet weak var petProfilePictureImageView: UIImageView!
  @IBOutlet weak var petNameAgeLabel: UILabel!
  
  var originalProfileCenter = CGPointZero
  var lastTouchPoint = CGPointZero
  
  var currentPet = Pet.randomPet()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setPetProfile()
    
    petProfileView.layer.cornerRadius = 8.0
    
    petProfilePictureImageView.layer.cornerRadius = 8.0
    petProfilePictureImageView.backgroundColor = UIColor.lightGrayColor()
    
    let pan = UIPanGestureRecognizer(target: self, action: #selector(IntroductionViewController.didPan(_:)))
    petProfileView.addGestureRecognizer(pan)
  }
  
  override func viewDidLayoutSubviews() {
    originalProfileCenter = petProfileView.center
    view.bringSubviewToFront(petProfileView)
  }
  
  @IBAction func rejectButtonWasTapped(sender: UIButton) {
    animateProfileViewLeft()
  }
  
  @IBAction func acceptButtonWasTapped(sender: UIButton) {
    animateProfileViewRight()
  }
  
  func didPan(pan: UIPanGestureRecognizer) {
    switch pan.state {
    case .Began:
      lastTouchPoint = pan.locationInView(view)
    case .Changed:
      let deltaX = pan.locationInView(view).x - lastTouchPoint.x
      let deltaY = pan.locationInView(view).y - lastTouchPoint.y
      
      petProfileView.center = CGPoint(x: petProfileView.center.x + deltaX, y: petProfileView.center.y + deltaY)
      lastTouchPoint = pan.locationInView(view)
    case .Ended:
      let velocity = pan.velocityInView(view)
      
      if abs(velocity.x) < 100 && abs(velocity.y) < 100 {
        animateProfileViewToOriginalPostion()
      } else {
        animateProfileViewOffscreen(withVelocity: velocity)
      }
    case .Cancelled, .Failed:
      animateProfileViewToOriginalPostion()
    default:
      break
    }
  }
  
  func animateProfileViewOffscreen(withVelocity velocity: CGPoint) {
    if petProfileView.center.x < UIScreen.mainScreen().bounds.size.width/2.0 {
      animateProfileViewLeft()
    } else {
      animateProfileViewRight()
    }
  }
  
  func animateProfileViewLeft() {
    let animation = CABasicAnimation(keyPath: "position")
    animation.toValue = NSValue(CGPoint: CGPoint(x: -(petProfileView.bounds.size.width), y: petProfileView.center.y))
    animation.fromValue = NSValue(CGPoint: petProfileView.center)
    animation.duration = 0.25
    animation.timingFunction =  CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    animation.removedOnCompletion = true
    
    CATransaction.begin()
    CATransaction.setCompletionBlock { () -> Void in
      self.resetPet()
    }
    
    petProfileView.layer.addAnimation(animation, forKey: "position")
    petProfileView.layer.position = animation.toValue!.CGPointValue
    CATransaction.commit()
  }
  
  func animateProfileViewRight() {
    let animation = CABasicAnimation(keyPath: "position")
    animation.toValue = NSValue(CGPoint: CGPoint(x: UIScreen.mainScreen().bounds.size.width + petProfileView.bounds.size.width, y: petProfileView.center.y))
    animation.fromValue = NSValue(CGPoint: petProfileView.center)
    animation.duration = 0.25
    animation.timingFunction =  CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    animation.removedOnCompletion = true
    
    animation.delegate = self
    
    CATransaction.begin()
    CATransaction.setCompletionBlock { () -> Void in
      if let image = self.petProfilePictureImageView.image {
        self.currentPet.imageData = UIImageJPEGRepresentation(image, 0)!
      }
      self.currentPet.id = MatchedPetsManager.sharedManager.matchedPets.count + 1
      MatchedPetsManager.sharedManager.addPet(self.currentPet)
      self.resetPet()
    }
    
    petProfileView.layer.addAnimation(animation, forKey: "position")
    petProfileView.layer.position = animation.toValue!.CGPointValue
    CATransaction.commit()
  }
  
  func resetPet() {
    petProfileView.alpha = 0.0
    petProfilePictureImageView.image = nil
    currentPet = Pet.randomPet()
    setPetProfile()
    petProfileView.center = originalProfileCenter
    fadeInProfileView()
  }
  
  func animateProfileViewToOriginalPostion() {
    let animation = CABasicAnimation(keyPath: "position")
    animation.toValue = NSValue(CGPoint: originalProfileCenter)
    animation.fromValue = NSValue(CGPoint: petProfileView.center)
    animation.duration = 0.25
    animation.timingFunction =  CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    animation.removedOnCompletion = true
    
    petProfileView.layer.addAnimation(animation, forKey: "position")
    petProfileView.layer.position = animation.toValue!.CGPointValue
  }
  
  func fadeInProfileView() {
    let animation = CABasicAnimation(keyPath: "opacity")
    animation.toValue = NSNumber(float: 1.0)
    animation.fromValue = NSNumber(float: 0.0)
    animation.duration = 0.25
    
    petProfileView.layer.addAnimation(animation, forKey: "opacity")
    petProfileView.layer.opacity = 1.0
  }
  
  func setPetProfile() {
    petNameAgeLabel.text = "\(currentPet.name), \(currentPet.age)"
    petProfilePictureImageView.loadURL(currentPet.imageURL)
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }
  
}
