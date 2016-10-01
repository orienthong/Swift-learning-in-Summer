//
//  AlbumHeader.swift
//  RWDevCon
//
//  Created by Mic Pringle on 09/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class AlbumHeader: UICollectionReusableView {
  
  @IBOutlet private weak var titleLabel: UILabel!
  
  var album: Album? {
    didSet {
      if let album = album {
        titleLabel.text = album.title
      }
    }
  }
  
}
