//
//  ResusableViews.swift
//  TacoPOP
//
//  Created by 洪浩东 on 8/18/16.
//  Copyright © 2016 scauos.com. All rights reserved.
//

import UIKit

protocol ReusableView: class { }

extension ReusableView where Self: UIView {
    static var resuseIdentifier: String {
        return String(self)
    }
}
 
