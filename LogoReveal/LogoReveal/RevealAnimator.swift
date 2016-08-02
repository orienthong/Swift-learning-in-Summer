//
//  RevealAnimator.swift
//  LogoReveal
//
//  Created by 洪浩东 on 8/2/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

class RevealAnimator: NSObject,UIViewControllerAnimatedTransitioning {
    let animationDuration = 1.0
    weak var storedContext: UIViewControllerContextTransitioning?
    
    var operation: UINavigationControllerOperation = .Push
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return animationDuration
    }
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if operation == .Push {
            storedContext = transitionContext
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! MasterViewController
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! DetailViewController
        toVC.view.alpha = 0.0
        transitionContext.containerView()?.addSubview(toVC.view)
        
        
        let animation = CABasicAnimation(keyPath: "transform")
        
        animation.fromValue = NSValue(CATransform3D: CATransform3DIdentity)
        animation.toValue = NSValue(CATransform3D: CATransform3DConcat(CATransform3DMakeTranslation(0.0, -10.0, 0.0), CATransform3DMakeScale(150.0, 150.0, 1.0)))
        animation.duration = animationDuration
        animation.delegate = self
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        toVC.maskLayer.addAnimation(animation, forKey: nil)
        fromVC.logo.addAnimation(animation, forKey: nil)
            UIView.animateWithDuration(animationDuration, animations: {
                toVC.view.alpha = 1.0
            })
        } else {
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
            
            transitionContext.containerView()?.insertSubview(toView, belowSubview: fromView)
            
            UIView.animateWithDuration(animationDuration, delay: 0.0, options: [.CurveEaseIn], animations: {
                fromView.transform = CGAffineTransformMakeScale(0.01, 0.01)
                }, completion: {_ in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            })
        }
    }
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if let context = storedContext {
            context.completeTransition(!context.transitionWasCancelled())
            let fromVC = context.viewControllerForKey(UITransitionContextFromViewControllerKey) as! MasterViewController
            fromVC.logo.removeAllAnimations()
        }
        storedContext = nil
    }
}
