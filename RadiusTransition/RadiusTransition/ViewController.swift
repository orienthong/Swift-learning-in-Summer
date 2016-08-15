//
//  ViewController.swift
//  RadiusTransition
//
//  Created by 洪浩东 on 8/15/16.
//  Copyright © 2016 scauos.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func BTNAction(_ sender: UIButton) {
        
        let SectionVC = self.storyboard?.instantiateViewController(withIdentifier: "SectionVC")
        self.navigationController?.radialPushViewController(viewController: SectionVC!, duration: 1.0, startFrame: CGRect(x: view.bounds.width, y: 0, width: 0, height: 0), transitionCompletion: nil)
        
    }
}

