//
//  Paper.swift
//  Wallpapers
//
//  Created by Mic Pringle on 07/01/2015.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import UIKit

class Paper {
  
  var caption: String
  var imageName: String
  var section: String
  var index: Int
  
  init(caption: String, imageName:String, section: String, index: Int) {
    self.caption = caption
    self.imageName = imageName
    self.section = section
    self.index = index
  }
  
  convenience init(copying paper: Paper) {
    self.init(caption: paper.caption, imageName: paper.imageName, section: paper.section, index: paper.index)
  }
  
}


