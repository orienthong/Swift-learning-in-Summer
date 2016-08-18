//
//  NibLoadableView.swift
//  TacoPOP
//
//  Created by 洪浩东 on 8/18/16.
//  Copyright © 2016 scauos.com. All rights reserved.
//

import UIKit

protocol NibLoadableView: class { }

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(self)
    }
    
}
