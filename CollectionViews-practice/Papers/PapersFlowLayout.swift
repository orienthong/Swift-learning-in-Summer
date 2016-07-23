//
//  PapersFlowLayout.swift
//  Papers
//
//  Created by 洪浩东 on 7/23/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

class PapersFlowLayout: UICollectionViewFlowLayout {
    var appearingIndexPath: NSIndexPath?
    
    override func initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attribute = super.initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath), _ = appearingIndexPath else {
            return nil
        }
        attribute.alpha = 1.0
        attribute.center = CGPoint(x: CGRectGetWidth((collectionView?.frame)!) - 23.5, y: -24.5)
        attribute.transform = CGAffineTransformMakeScale(0.15, 0.15)
        attribute.zIndex = 99
        
        return attribute
    }
}
