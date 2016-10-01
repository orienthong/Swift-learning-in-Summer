//
//  RadiusView.swift
//  RWBooks
//
//  Created by 洪浩东 on 7/20/16.
//  Copyright © 2016 Ray Wenderlich. All rights reserved.
//

import UIKit
@IBDesignable
class RadiusView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.TopLeft,.TopRight], cornerRadii: CGSize(width: 30.0, height: 30.0)).CGPath
        layer.mask = shapeLayer
    }
}
