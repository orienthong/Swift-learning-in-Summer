//
//  MenuHelper.swift
//  SlideMenu
//
//  Created by 洪浩东 on 7/28/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import Foundation

enum Direction {
    case Up
    case Down
    case Left
    case Right
}

struct MenuHelper {
    static let menuWidth: CGFloat = 0.4
    static let percentThreshould: CGFloat = 0.3
    static let snapNumber = 12345
    
    static func calculateProgress(translationInView:CGPoint, viewBounds:CGRect, direction:Direction) -> CGFloat {
        let pointOnAxis:CGFloat
        let axisLength:CGFloat
        switch direction {
        case .Up, .Down:
            pointOnAxis = translationInView.y
            axisLength = viewBounds.height
        case .Left, .Right:
            pointOnAxis = translationInView.x
            axisLength = viewBounds.width
        }
        let movementOnAxis = pointOnAxis / axisLength
        let positiveMovementOnAxis:Float
        let positiveMovementOnAxisPercent:Float
        switch direction {
        case .Right, .Down: // positive
            positiveMovementOnAxis = fmaxf(Float(movementOnAxis), 0.0)
            positiveMovementOnAxisPercent = fminf(positiveMovementOnAxis, 1.0)
            return CGFloat(positiveMovementOnAxisPercent)
        case .Up, .Left: // negative
            positiveMovementOnAxis = fminf(Float(movementOnAxis), 0.0)
            positiveMovementOnAxisPercent = fmaxf(positiveMovementOnAxis, -1.0)
            return CGFloat(-positiveMovementOnAxisPercent)
        }
    }
    static func mapGestureStateToInteractor(gestureState:UIGestureRecognizerState, progress:CGFloat, interactor: Interactor?, triggerSegue: () -> Void) {
        guard let interactor = interactor else { return }
        switch gestureState {
        case .Began:
            interactor.hasStarted = true
        case .Changed:
            interactor.shouldFinish = progress > percentThreshould
            interactor.cancelInteractiveTransition()
        case .Ended:
            interactor.hasStarted = false
            interactor.shouldFinish
            ? interactor.finishInteractiveTransition()
            : interactor.cancelInteractiveTransition()
        default:
            break
        }
    }
}
