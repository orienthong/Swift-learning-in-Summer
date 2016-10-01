//
//  ScaryBugCell.swift
//  ScaryBugs
//
//  Created by 洪浩东 on 7/22/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

class ScaryBugCell: UITableViewCell {

    @IBOutlet weak var bugImageView: UIImageView!
    
    @IBOutlet weak var bugNameLabel: UILabel!
    
    @IBOutlet weak var howScaryImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
