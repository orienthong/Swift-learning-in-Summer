//
//  StickyHeadersLayout.swift
//  Camera Roll
//
//  Created by 洪浩东 on 7/24/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

class StickyHeadersLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = super.layoutAttributesForElementsInRect(rect) as [UICollectionViewLayoutAttributes]!
        
        let headersNeedingLayout = NSMutableIndexSet()
        for attributes in layoutAttributes {
            if attributes.representedElementCategory == .Cell {
                headersNeedingLayout.addIndex(attributes.indexPath.section)
            }
        }
        for attributes in layoutAttributes {
            if let elementKind = attributes.representedElementKind {
                if elementKind == UICollectionElementKindSectionHeader {
                    headersNeedingLayout.removeIndex(attributes.indexPath.section)
                }
            }
        }
        headersNeedingLayout.enumerateIndexesUsingBlock { (index, stop) -> Void in
            let indexPath = NSIndexPath(forItem: 0, inSection: index)
            let attributes = self.layoutAttributesForSupplementaryViewOfKind(UICollectionElementKindSectionHeader, atIndexPath: indexPath)!
            layoutAttributes.append(attributes)
        }
        
        for attributes in layoutAttributes {
            if let elementKind = attributes.representedElementKind {
                if elementKind == UICollectionElementKindSectionHeader {
                    let section = attributes.indexPath.section
                    let attributesForFirstItemInSection = layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: 0, inSection: section))!
                    let attributesForLastItemInSection = layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: collectionView!.numberOfItemsInSection(section) - 1, inSection: section))!
                    var frame = attributes.frame
                    let offset = collectionView!.contentOffset.y
                    
                    /* The header should never go further up than one-header-height above
                     the upper bounds of the first cell in the current section */
                    let minY = CGRectGetMinY(attributesForFirstItemInSection.frame) - frame.height
                    /* The header should never go further down than one-header-height above
                     the lower bounds of the last cell in the section */
                    let maxY = CGRectGetMaxY(attributesForLastItemInSection.frame) - frame.height
                    /* If it doesn't break either of those two rules then it should be
                     positioned using the y value of the content offset */
                    let y = min(max(offset, minY), maxY)
                    
                    frame.origin.y = y
                    attributes.frame = frame
                    attributes.zIndex = 99
                }
            }
        }
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
}
