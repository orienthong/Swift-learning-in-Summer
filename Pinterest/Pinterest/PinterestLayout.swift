//
//  PinterestLayout.swift
//  Pinterest
//
//  Created by 洪浩东 on 7/24/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit
protocol PinterestLayoutDelegate {
    func collectionView(collectionView: UICollectionView,heightForItemAtIndexPath: NSIndexPath) -> CGFloat
}
class PinterestLayout: UICollectionViewLayout{
    
    var delegate : PinterestLayoutDelegate!
    var numberOfColumns = 1
    var cellPadding: CGFloat = 0
    private var cache = [UICollectionViewLayoutAttributes]()
    private var contentHeight : CGFloat = 0
    private var width: CGFloat {
        get{
            
            let insets  = collectionView!.contentInset
            return CGRectGetWidth(collectionView!.bounds) - (insets.left + insets.right)
        }
    }
    override func collectionViewContentSize() -> CGSize {
        return CGSize(width: width, height: contentHeight)
    }
    override func prepareLayout() {
        if cache.isEmpty {
            let columnWidth = width / CGFloat(numberOfColumns)
            
            var Xoffsets = [CGFloat]()
            for column in 0 ..< numberOfColumns {
                Xoffsets.append(CGFloat(column) * columnWidth)
            }
            var Yoffsets = [CGFloat](count: numberOfColumns, repeatedValue: 0)
            
            var column = 0
            for item in 0 ..< collectionView!.numberOfItemsInSection(0) {
                let indexPath = NSIndexPath(forItem: item, inSection: 0)
                let height = delegate.collectionView(collectionView!, heightForItemAtIndexPath: indexPath)
                
                let frame = CGRect(x: Xoffsets[column], y: Yoffsets[column], width: columnWidth, height: height)
                let insetFrame = CGRectInset(frame, cellPadding, cellPadding)
                let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
                attributes.frame = insetFrame
                cache.append(attributes)
                contentHeight = max(contentHeight, CGRectGetMaxY(frame))
                Yoffsets[column] = Yoffsets[column] + height
                column = column >= (numberOfColumns - 1) ? 0 : column+1
            }
        }
    }
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if CGRectIntersectsRect(attributes.frame, rect) {
                layoutAttributes.append(attributes)
            }
        }
        
        return layoutAttributes
    }
    
    
}
