//
//  HorizontalScroller.swift
//  BlueLibrarySwift
//
//  Created by 洪浩东 on 8/23/16.
//  Copyright © 2016 Raywenderlich. All rights reserved.
//

import Foundation
import UIKit

//没有option ， 就是必须实现的
@objc protocol HorizontalScrollerDelegate {
    // 在横滑视图中有多少页面需要展示
    func numberOfViewsForHorizontalScroller(scroller: HorizontalScroller) -> Int
    // 展示在第 index 位置显示的 UIView
    func horizontalScrollerViewAtIndex(scroller: HorizontalScroller, index:Int) -> UIView
    // 通知委托第 index 个视图被点击了
    func horizontalScrollerClickedViewAtIndex(scroller: HorizontalScroller, index:Int)
    // 可选方法，返回初始化时显示的图片下标，默认是0
    optional func initialViewIndex(scroller: HorizontalScroller) -> Int
}
class HorizontalScroller: UIView{
    weak var delegate: HorizontalScrollerDelegate?
    
    private var VIEW_PADDING = 10
    private var VIEW_DIMENSIONS = 100
    private var VIEWS_OFFSET = 100
    
    private var scroller: UIScrollView!
    
    var viewArray = [UIView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeScrollView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initializeScrollView()
    }
    
    func initializeScrollView() {
        //1
        scroller = UIScrollView()
        scroller.delegate = self
        addSubview(scroller)
        
        //2
        scroller.translatesAutoresizingMaskIntoConstraints = false
        
        //3
        self.addConstraint(NSLayoutConstraint(item: scroller, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: scroller, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: scroller, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: scroller, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0.0))
        
        //4
        let tapRecognizer = UITapGestureRecognizer(target: self, action:#selector(HorizontalScroller.scrollerTapped(_:)))
        scroller.addGestureRecognizer(tapRecognizer)
    }
    func scrollerTapped(gesture: UITapGestureRecognizer) {
        let location = gesture.locationInView(gesture.view)
        if let delegate = self.delegate {
            for index in 0 ..< delegate.numberOfViewsForHorizontalScroller(self) {
                let view = scroller.subviews[index] as UIView
                if CGRectContainsPoint(view.frame, location) {
                    delegate.horizontalScrollerClickedViewAtIndex(self, index: index)
                    scroller.setContentOffset(CGPointMake(view.frame.origin.x - self.frame.size.width / 2, 0), animated: true)
                    break
                }
            }
        }
    }
    func viewAtIndex(index: Int) -> UIView {
        return viewArray[index]
    }
    func reload() {
        if let delegate = delegate {
            viewArray = []
            let views: NSArray = scroller.subviews
            
            views.enumerateObjectsUsingBlock {
                (object: AnyObject!, idx: Int, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
                object.removeFromSuperview()
            }
            
            var xValue = VIEWS_OFFSET
            for index in 0 ..< delegate.numberOfViewsForHorizontalScroller(self) {
                xValue += VIEW_PADDING
                let view = delegate.horizontalScrollerViewAtIndex(self, index: index)
                view.frame = CGRectMake(CGFloat(xValue), CGFloat(VIEW_PADDING), CGFloat(VIEW_DIMENSIONS), CGFloat(VIEW_DIMENSIONS))
                scroller.addSubview(view)
                xValue += VIEW_DIMENSIONS + VIEW_PADDING
                // 6 - Store the view so we can reference it later
                viewArray.append(view)
            }
            // 7
            scroller.contentSize = CGSizeMake(CGFloat(xValue + VIEWS_OFFSET), frame.size.height)
            
            // 8 - If an initial view is defined, center the scroller on it
            if let initialView = delegate.initialViewIndex?(self) {
                let xFinal = CGFloat(initialView) * CGFloat(VIEW_DIMENSIONS + (2*VIEW_PADDING)) - CGFloat(3*VIEW_PADDING)
                scroller.setContentOffset(CGPointMake(xFinal, 0), animated: true)
            }
        }
    }
    override func didMoveToSuperview() {
        reload()
    }
    func centerCurrentView() {
        var xFinal = scroller.contentOffset.x + CGFloat(VIEWS_OFFSET / 2 + VIEW_PADDING)
        let viewIndex = xFinal / CGFloat(VIEW_DIMENSIONS + 2 * VIEW_PADDING)
        xFinal = viewIndex * CGFloat(VIEW_DIMENSIONS + 2 * VIEW_PADDING ) - CGFloat(3 * VIEW_PADDING)
        
        scroller.setContentOffset(CGPointMake(xFinal, 0), animated: true)
        if let delegate = delegate {
            delegate.horizontalScrollerClickedViewAtIndex(self, index: Int(viewIndex))
        }
    }
}
extension HorizontalScroller: UIScrollViewDelegate {
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            centerCurrentView()
        }
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        centerCurrentView()
    }
    
}

