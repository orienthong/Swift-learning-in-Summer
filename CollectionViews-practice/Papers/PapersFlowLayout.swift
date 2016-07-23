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
    var disappearingIndexPaths: [NSIndexPath]?
    
    override func initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attribute = super.initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath), indexPath = appearingIndexPath where indexPath == itemIndexPath else {
            return nil
        }
        attribute.alpha = 1.0
        attribute.center = CGPoint(x: CGRectGetWidth((collectionView?.frame)!) - 23.5, y: -24.5)
        attribute.transform = CGAffineTransformMakeScale(0.15, 0.15)
        attribute.zIndex = 99
        
        return attribute
    }
    override func finalLayoutAttributesForDisappearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.finalLayoutAttributesForDisappearingItemAtIndexPath(itemIndexPath), indexPaths = disappearingIndexPaths where indexPaths.contains(itemIndexPath) else {
            return nil
        }
        attributes.alpha = 1.0
        attributes.transform = CGAffineTransformMakeScale(0.1, 0.1)
        attributes.zIndex = -1
        return attributes
    }
}
