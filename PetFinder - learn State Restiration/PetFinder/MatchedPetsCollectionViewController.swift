//
//  MatchedPetsCollectionViewController.swift
//  PetFinder
//
//  Created by Luke Parham on 8/31/15.
//  Copyright © 2015 Luke Parham. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PetCell"

class MatchedPetsCollectionViewController: UICollectionViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    clearsSelectionOnViewWillAppear = false
    
    collectionView!.backgroundColor = UIColor.clearColor()
    
    title = "Matches"
  }
  
  override func viewDidAppear(animated: Bool) {
    let selectedItems: [NSIndexPath]? = collectionView?.indexPathsForSelectedItems()
    if selectedItems?.count != 0 {
      UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
        self.collectionView!.deselectItemAtIndexPath((selectedItems?.first)!, animated: true)
        }, completion: nil)
    }
    
  }
  
  override func viewWillAppear(animated: Bool) {
    if MatchedPetsManager.sharedManager.matchedPets.count != collectionView?.numberOfItemsInSection(0) {
      collectionView?.reloadData()
    }
  }
  
  // MARK: - Navigation
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let cell: PetCell? = sender as? PetCell
    let vc: PetDetailsViewController? = segue.destinationViewController as? PetDetailsViewController
    
    if let cell = cell, vc = vc {
      cell.selected = true
      vc.petId = cell.petId
    }
  }
  
  // MARK: UICollectionViewDataSource
  
  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return MatchedPetsManager.sharedManager.matchedPets.count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PetCell
    
    cell.petId = MatchedPetsManager.sharedManager.matchedPets[indexPath.row].id
    
    return cell
  }
  
  // MARK: UICollectionViewDelegate
  
  // Uncomment this method to specify if the specified item should be selected
  override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
  override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return false
  }
  
  override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
    return false
  }
}