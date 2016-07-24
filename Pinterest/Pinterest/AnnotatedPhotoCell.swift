//
//  AnnotatedPhotoCell.swift
//  RWDevCon
//
//  Created by Mic Pringle on 26/02/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class AnnotatedPhotoCell: UICollectionViewCell {
  
  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
  
  var photo: Photo? {
    didSet {
      if let photo = photo {
        imageView.image = photo.image
      }
    }
  }
  
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        let attributes = layoutAttributes as! PinterestLayoutAttributes
        imageViewHeightLayoutConstraint.constant = attributes.photoHight
    }
}
