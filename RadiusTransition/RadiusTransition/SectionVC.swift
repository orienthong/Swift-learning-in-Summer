//
//  SectionVC.swift
//  RadiusTransition
//
//  Created by 洪浩东 on 8/15/16.
//  Copyright © 2016 scauos.com. All rights reserved.
//

import UIKit

class SectionVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.enableRadialSwipe()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: Selector(("simplePop")))
    }
    func simplePop(sender: UIButton) {
        print("Het")
        navigationController?.radialPopViewController()
    }
}
