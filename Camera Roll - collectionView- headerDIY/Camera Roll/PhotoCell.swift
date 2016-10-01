//
//  PhotoCell.swift
//  RWDevCon
//
//  Created by Mic Pringle on 09/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
  
  @IBOutlet private weak var imageView: UIImageView!
  
  var photo: UIImage? {
    didSet {
      if let photo = photo {
        imageView.image = photo
      }
    }
  }
  
}
