//
//  ViewController.swift
//  CALayerPlayground
//
//  Created by 洪浩东 on 7/20/16.
//  Copyright © 2016 scauos.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var viewForLayer: UIView!
    
    var l : CALayer {
        return viewForLayer.layer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpLayer(){
        l.backgroundColor = UIColor.redColor().CGColor
        l.borderWidth = 100.0
        l.borderColor = UIColor.blueColor().CGColor
        l.shadowOpacity = 0.7
        l.shadowRadius = 10.0
        l.contents = UIImage(named: "star")?.CGImage
        l.contentsGravity = kCAGravityCenter
    }

    @IBAction func tapGestureRecognized(sender: UITapGestureRecognizer) {
        l.shadowOpacity = l.shadowOpacity == 0.7 ? 0.3 : 0.7
    }
    @IBAction func pinchGestureRecognized(sender: UIPinchGestureRecognizer) {
        
    }
    
}

