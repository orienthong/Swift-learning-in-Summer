//
//  ViewController.swift
//  ScrollView - practice
//
//  Created by 洪浩东 on 7/24/16.
//  Copyright © 2016 scauos.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var originLabel = UILabel(frame: CGRect(x: 20, y: 30, width: 0, height: 0))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(image: UIImage(named: "zombies.jpg"))
        let srollView = UIScrollView(frame: view.bounds)
        srollView.autoresizingMask = [.FlexibleWidth , .FlexibleHeight]
        srollView.backgroundColor = UIColor.blackColor()
        srollView.contentSize = imageView.bounds.size
        
        srollView.addSubview(imageView)
        view.addSubview(srollView)
        
        //set content offSet
        srollView.contentOffset = CGPoint(x: 60, y: 342.5)
        
        
        originLabel.backgroundColor = UIColor.blackColor()
        originLabel.textColor = UIColor.whiteColor()
        
        view.addSubview(originLabel)
        srollView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        originLabel.text = "\(scrollView.contentOffset)"
        originLabel.sizeToFit()
    }
}

