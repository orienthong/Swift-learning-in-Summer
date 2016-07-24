//
//  DIYLayout.swift
//  DIY
//
//  Created by 洪浩东 on 7/24/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit


class DIYLayoutAttributes: UICollectionViewLayoutAttributes {
    var delaY : CGFloat = 0
    override func copyWithZone(zone: NSZone) -> AnyObject {
        let copy = super.copyWithZone(zone) as! DIYLayoutAttributes
        copy.delaY = delaY
        return copy
    }
    override func isEqual(object: AnyObject?) -> Bool {
        if let attributes = object as? DIYLayoutAttributes {
            if attributes.delaY == delaY {
                return super.isEqual(object)
            }
        }
        return false
    }
}

class DIYLayout: UICollectionViewFlowLayout {
    
    override class func layoutAttributesClass() -> AnyClass {
        return DIYLayoutAttributes.self
    }
    
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let insets = collectionView!.contentInset
        
        let layoutAttributes = super.layoutAttributesForElementsInRect(rect) as! [DIYLayoutAttributes]
        
        let offset = collectionView!.contentOffset
        let minY = -insets.top
        if (offset.y < minY) {
            let deltaY = fabs(offset.y - minY)
            for attributes in layoutAttributes {
                if let elementKind = attributes.representedElementKind {
                    if elementKind == UICollectionElementKindSectionHeader {
                        var frame = attributes.frame
                        frame.size.height = max(minY, headerReferenceSize.height + deltaY)
                        frame.origin.y = CGRectGetMinY(frame) - deltaY
                        attributes.frame = frame
                        attributes.delaY = deltaY
                    }
                }
            }
        }
        return layoutAttributes
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
}
