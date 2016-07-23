//
//  PaperCell.swift
//  Papers
//
//  Created by Tim Mitra on 2/14/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

class PaperCell: UICollectionViewCell {
    
  @IBOutlet weak var paperImageView: UIImageView!
  @IBOutlet private weak var gradientView: GradientView!
  @IBOutlet private weak var captionLabel: UILabel!
  
    @IBOutlet weak var checkImageView: UIImageView!
  var paper: Paper? {
    didSet {
      if let paper = paper {
        paperImageView.image = UIImage(named: paper.imageName)
        captionLabel.text = paper.caption
      }
    }
  }
    var editing: Bool = false {
        didSet {
            checkImageView.hidden = !editing
            captionLabel.hidden = editing
        }
    }
    override var selected: Bool {
        didSet {
            if editing {
                checkImageView.image = UIImage(named: selected ? "Checked" : "Unchecked")
            }
        }
    }
}
