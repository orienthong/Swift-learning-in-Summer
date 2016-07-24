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
    let imageView = UIImageView(image: UIImage(named: "zombies.jpg"))
    var scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.autoresizingMask = [.FlexibleWidth , .FlexibleHeight]
        scrollView.backgroundColor = UIColor.blackColor()
        scrollView.contentSize = imageView.bounds.size
        
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        //set content offSet
        scrollView.contentOffset = CGPoint(x: 60, y: 342.5)
        
        
        
        
        originLabel.backgroundColor = UIColor.blackColor()
        originLabel.textColor = UIColor.whiteColor()
        
        view.addSubview(originLabel)
        scrollView.delegate = self
        
        setZoomParametersForSize(scrollView.bounds.size)
        
    }
    func setZoomParametersForSize(scrollViewSize: CGSize){
        let imageViewsize = imageView.bounds.size
        let zoomX = scrollViewSize.width / imageViewsize.width
        let zoomY = scrollViewSize.height / imageViewsize.height
        
        let minZooming = min(zoomX,zoomY)
        scrollView.minimumZoomScale = minZooming
        scrollView.maximumZoomScale = 1.5
        scrollView.zoomScale = minZooming
    }
    override func viewWillLayoutSubviews() {
        setZoomParametersForSize(scrollView.bounds.size)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension ViewController: UIScrollViewDelegate{
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        originLabel.text = "\(scrollView.contentOffset)"
        originLabel.sizeToFit()
    }
}

