//
//  ViewController.swift
//  UIViewPropertyAnimator
//
//  Created by 洪浩东 on 8/16/16.
//  Copyright © 2016 scauos.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var circleCenter: CGPoint!
    
    // add Animator
    var circleAnimator: UIViewPropertyAnimator!
    let duration = 4.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add a draggable view
        let circle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
        circle.center = view.center
        circle.layer.cornerRadius = 50.0
        circle.backgroundColor = UIColor.green
        
        circle.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.dragCircle)))
//        circleAnimator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut, animations: {
//            [unowned circle] in
//            circle.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
//        })
        view.addSubview(circle)
    }
    
    func dragCircle(gesture: UIPanGestureRecognizer) {
        let target = gesture.view!
        
        switch gesture.state {
        case .began:
            if circleAnimator != nil && circleAnimator!.isRunning {
                circleAnimator!.stopAnimation(false)
            }
            circleCenter = target.center
        case .changed:
            let translation = gesture.translation(in: self.view)
            target.center = CGPoint(x: circleCenter!.x + translation.x, y: circleCenter!.y + translation.y)
        case .ended:
            let v = gesture.velocity(in: target)
            // 500 is an arbitrary value that looked pretty good, you may want to base this on device resolution or view size.
            // The y component of the velocity is usually ignored, but is used when animating the center of a view
            let velocity = CGVector(dx: v.x / 500, dy: v.y / 500)
            let springParameters = UISpringTimingParameters(mass: 2.5, stiffness: 70, damping: 55, initialVelocity: velocity)
            circleAnimator = UIViewPropertyAnimator(duration: 0.0, timingParameters: springParameters)
            
            circleAnimator!.addAnimations({
                target.center = self.view.center
            })
            circleAnimator!.startAnimation()
        default: break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

