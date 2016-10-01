//
//  SwipeInteractionController.swift
//  GuessThePet
//
//  Created by 洪浩东 on 7/29/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

class SwipeInteractionController: UIPercentDrivenInteractiveTransition {
    var interctionInProgress = false
    private var shouldCompleteTransition = false
    private weak var viewController: UIViewController!
    
    func wireToViewController(viewController: UIViewController!) {
        self.viewController = viewController
        prepareGestureRecognizerInView(viewController.view)
    }
    private func  prepareGestureRecognizerInView(view: UIView) {
        let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        gesture.edges = UIRectEdge.Left
        view.addGestureRecognizer(gesture)
    }
    func handleGesture(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        let transition = gestureRecognizer.translationInView(gestureRecognizer.view!.superview!)
        var progress = transition.x / 200
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        
        switch gestureRecognizer.state {
        case .Began:
            interctionInProgress = true
            viewController.dismissViewControllerAnimated(true, completion: nil)
        case .Changed:
            // 3
            shouldCompleteTransition = progress > 0.5
            updateInteractiveTransition(progress)
            
        case .Cancelled:
            // 4
            interctionInProgress = false
            cancelInteractiveTransition()
            
        case .Ended:
            // 5
            interctionInProgress = false
            
            if !shouldCompleteTransition {
                cancelInteractiveTransition()
            } else {
                finishInteractiveTransition()
            }
            
        default:
            print("Unsupported")
        }
    }
}
