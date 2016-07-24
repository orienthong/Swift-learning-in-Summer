//
//  CameraRollViewController.swift
//  RWDevCon
//
//  Created by Mic Pringle on 09/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class CameraRollViewController: UICollectionViewController {
  
  let albums = Album.allAlbums()
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let patternImage = UIImage(named: "Pattern") {
      view.backgroundColor = UIColor(patternImage: patternImage)
    }
    collectionView!.backgroundColor = UIColor.clearColor()
    
    let width = CGRectGetWidth(collectionView!.bounds) / 2
    let layout = collectionViewLayout! as UICollectionViewFlowLayout
    layout.itemSize = CGSize(width: width, height: width)
  }
}

extension CameraRollViewController {
  
  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return albums.count
  }
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return albums[section].photos.count
  }
  
  override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "AlbumHeader", forIndexPath: indexPath) as AlbumHeader
    header.album = albums[indexPath.section]
    return header
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let photo = albums[indexPath.section].photos[indexPath.item]
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as PhotoCell
    cell.photo = photo
    return cell
  }
  
}