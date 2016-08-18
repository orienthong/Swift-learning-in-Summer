//
//  DropShadow.swift
//  TacoPOP
//
//  Created by 洪浩东 on 8/16/16.
//  Copyright © 2016 scauos.com. All rights reserved.
//

import UIKit

protocol DropShadow {}

extension DropShadow where Self: UIView {
    func addDropShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
    }
}
