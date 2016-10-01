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
    
    func reCenterImage() {
        let scrollViewSize = scrollView.bounds.size
        print("scrollView.bounds.size\(scrollViewSize)")
        print("scrollView.frame.size\(scrollView.frame.size)")
        let imageViewSize = imageView.frame.size
        print("imageView.frame.size\(imageView.frame.size)")
        print("imageView.bounds.size\(imageView.bounds.size)")
        let horizontalSpace  = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        let VorizontalSpace = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        scrollView.contentInset = UIEdgeInsets(top: VorizontalSpace, left: horizontalSpace, bottom: VorizontalSpace, right: horizontalSpace)
        
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
        reCenterImage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        let centerPoint = CGPoint(x: scrollView.contentOffset.x + CGRectGetWidth(scrollView.bounds) / 2 , y: scrollView.contentOffset.y + CGRectGetHeight(scrollView.bounds) / 2 )
        coordinator.animateAlongsideTransition({
            (context) -> Void in
            self.scrollView.contentOffset = CGPoint(x: centerPoint.x - size.width / 2, y: centerPoint.y - size.height / 2)
            }, completion: nil)
        
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

