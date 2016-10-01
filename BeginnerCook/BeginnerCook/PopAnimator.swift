//
//  PopAnimator.swift
//  BeginnerCook
//
//  Created by 洪浩东 on 8/1/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

class PopAnimator: NSObject,UIViewControllerAnimatedTransitioning {
    
    var presenting = false
    let duration = 1.0
    var originFrame = CGRect.zero
    var dismissCompletion: (() -> ())?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let containView = transitionContext.containerView() , let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) , let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) else { return }
        
        let herbView = presenting ? toVC.view! : fromVC.view!
        let initialFrame = presenting ? originFrame : herbView.frame
        let finalFrame = presenting ? herbView.frame : originFrame
        
        let xScaleFactor = presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        let yScaleFactor = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor)
        
        let herbController = transitionContext.viewControllerForKey(
            presenting ? UITransitionContextToViewControllerKey : UITransitionContextFromViewControllerKey
            ) as! HerbDetailsViewController
        if presenting {
            herbController.containerView.alpha = 0
        }
        
        if presenting {
            herbView.transform = scaleTransform
            herbView.center = CGPoint(x: CGRectGetMidX(initialFrame), y: CGRectGetMidY(initialFrame))
            herbView.clipsToBounds = true
        }
        
        containView.addSubview(toVC.view)
        containView.bringSubviewToFront(herbView)
        
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [], animations: {
            herbView.transform = self.presenting ? CGAffineTransformIdentity : scaleTransform
            herbView.center = CGPoint(x: CGRectGetMidX(finalFrame), y: CGRectGetMidY(finalFrame))
            herbController.containerView.alpha = self.presenting ? 1.0 : 0.0
            }, completion: {
                _ in
                if !self.presenting {
                    self.dismissCompletion?()
                }
                transitionContext.completeTransition(true)
                
        })
        let round = CABasicAnimation(keyPath: "cornerRadius")
        round.fromValue = !presenting ? 0.0 : 20.0 / xScaleFactor
        round.toValue = presenting ? 0.0 : 20.0 / xScaleFactor
//        round.delegate = self
        round.duration = duration / 2
        herbView.layer.addAnimation(round, forKey: nil)
        herbView.layer.cornerRadius = presenting ? 0.0 : 20.0 / xScaleFactor
    }
}
