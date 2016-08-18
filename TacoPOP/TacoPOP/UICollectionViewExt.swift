//
//  UICollectionViewExt.swift
//  TacoPOP
//
//  Created by 洪浩东 on 8/18/16.
//  Copyright © 2016 scauos.com. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell where T: ReusableView,  T: NibLoadableView>(_: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.resuseIdentifier)
    }
    
    func dequeueReusablCell<T: UICollectionViewCell where T: ReusableView>(forIndexPath indexPath: NSIndexPath) -> T {
        
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.resuseIdentifier, for: indexPath as IndexPath) as? T else {
            
            fatalError("Could not dequeue cell with identifier: \(T.resuseIdentifier)")
        }
        return cell
    }
}

extension UICollectionViewCell: ReusableView {}

