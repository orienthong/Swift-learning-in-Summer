//
//  PhotoStreamViewController.swift
//  RWDevCon
//
//  Created by Mic Pringle on 26/02/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class PhotoStreamViewController: UICollectionViewController {
  
  
  var photos = Photo.allPhotos()

  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let patternImage = UIImage(named: "Pattern") {
      view.backgroundColor = UIColor(patternImage: patternImage)
    }
    
    collectionView!.backgroundColor = UIColor.clearColor()
    collectionView?.contentInset = UIEdgeInsets(top: 23, left: 5, bottom: 10, right: 5)
    let layout = collectionViewLayout as! PinterestLayout
    layout.delegate = self
    layout.numberOfColumns = 2
    layout.cellPadding = 5
  }
  
}
//MARK: - dataSource
extension PhotoStreamViewController {
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AnnotatedPhotoCell", forIndexPath: indexPath) as UICollectionViewCell
    return cell
  }
  
}

extension PhotoStreamViewController: PinterestLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath heightForItemAtIndexPath: NSIndexPath,withWidth width: CGFloat) -> CGFloat {
        let random = arc4random_uniform(4) + 1
        return CGFloat(random * 100)
    }
    func collectionView(collectionView: UICollectionView, heightForAnnonationAtIndexPath: NSIndexPath,withWidth width: CGFloat) -> CGFloat {
        return 60
    }
}
