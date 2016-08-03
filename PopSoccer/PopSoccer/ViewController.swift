/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class ViewController: UIViewController {

  @IBOutlet var goal: UIImageView!
  @IBOutlet var ball: UIImageView!
    weak var currentMessage: UILabel?
  var playingRect: CGRect!
  var observeBounds = true
    var minX: CGFloat = 0
    var maxX: CGFloat = 0
  
  override func viewDidLoad() {
    ball.addObserver(self, forKeyPath: "alpha", options: .New, context: nil)
    super.viewDidLoad()

    //setup ball interaction
    minX = ball.frame.size.width / 2
    maxX = view.frame.size.width - minX
    ball.userInteractionEnabled = true
    ball.addGestureRecognizer(
      UIPanGestureRecognizer(target: self, action: #selector(ViewController.didPan(_:)))
    )
    resetBall()
    let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTap(_:)))
    view.addGestureRecognizer(tap)
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    ball.alpha = 0.0
    
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    fadeInView(ball)
    animateMessage("Game On!")
  }
  
  func didPan(pan: UIPanGestureRecognizer) {
    switch pan.state {
    case .Began:
        ball.pop_removeAllAnimations()
        ball.center = pan.locationInView(view)
//        print(pan.velocityInView(view))
    case .Ended:
        let velocity = pan.velocityInView(view)
        let animation = POPDecayAnimation(propertyNamed: kPOPViewCenter)
        animation.fromValue = NSValue(CGPoint: ball.center)
        animation.velocity = NSValue(CGPoint: velocity)
        
        animation.delegate = self
        ball.pop_addAnimation(animation, forKey: nil)
    default:
        break
    }
    
  }
  
  func resetBall() {
    //set ball at random position on the field
    let randomX = CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    ball.center = CGPoint(x: randomX * view.frame.size.width, y: view.frame.size.height * 0.7)
    fadeInView(ball)
  }
    func fadeInView(view: UIView){
        /*
        UIView.animateWithDuration(1.0, animations: {
            view.alpha = 1.0
        })
        */
        let fade = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        fade.fromValue = 0.0
        fade.toValue = 1.0
        fade.duration = 1.0
        view.pop_addAnimation(fade, forKey: nil)
    }
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if object === ball && keyPath == "alpha" {
//            print(ball.alpha)
        } else{
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    //set up the label
    func animateMessage(text: String) {
        let offScreenFrame = CGRect(x: -view.frame.size.width, y: 200, width: view.frame.size.width, height: 50.0)
        let label = UILabel(frame: offScreenFrame)
        
        label.font = UIFont(name: "ArialRoundedMTBold", size: 52.0)
        label.textAlignment = .Center
        label.textColor = UIColor.yellowColor()
        label.text = text
        label.shadowColor = UIColor.darkGrayColor()
        label.shadowOffset = CGSize(width: 2.0, height: 2.0)
        
        currentMessage = label
        view.addSubview(label)
        
        let bounce = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        bounce.fromValue = NSValue(CGPoint: label.center)
        bounce.toValue = NSValue(CGPoint: view.center)
        bounce.springSpeed = 15.0
        bounce.springBounciness = 20.0
        bounce.completionBlock = { animation, finished in
            let fadeOut = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
            fadeOut.duration = 0.5
            fadeOut.toValue = 0.0
            fadeOut.completionBlock = {_, _ in
                label.removeFromSuperview()
            }
            label.pop_addAnimation(fadeOut, forKey: "shot")
            print(self.currentMessage!.text)
        }
        label.pop_addAnimation(bounce, forKey: "bounce")
    }
    func didTap(tap: UITapGestureRecognizer) {
        if let label = currentMessage {
            if let bounce = label.pop_animationForKey("bounce") as? POPSpringAnimation {
                bounce.toValue = NSValue(CGPoint: tap.locationInView(view))
            }
        }
    }
}
extension ViewController: POPAnimationDelegate {
    func pop_animationDidStop(anim: POPAnimation!, finished: Bool) {
        if finished {
            resetBall()
        }
    }
    func pop_animationDidApply(anim: POPAnimation!) {
        if goal.frame.contains(ball.center) {
            ball.pop_removeAllAnimations()
            animateMessage("Goal")
            resetBall()
            return
        }
        if ball.center.x < minX || ball.center.x > maxX {
            if let delay = anim as? POPDecayAnimation {
                let velocityValue = delay.velocity as! NSValue
                let velocity = velocityValue.CGPointValue()
                ball.pop_removeAllAnimations()
                
                let newPoint = CGPoint(x: -velocity.x, y: velocity.y)
                let newX = min(max(minX, ball.center.x), maxX)
                
                let newAnimation = POPDecayAnimation(propertyNamed: kPOPViewCenter)
                newAnimation.fromValue = NSValue(CGPoint: CGPoint(x: newX, y: ball.center.y))
                newAnimation.velocity = NSValue(CGPoint: newPoint)
                newAnimation.delegate = self
                ball.pop_addAnimation(newAnimation, forKey: "shot")
            }
        }
        if ball.center.y < 0 || ball.center.y > view.frame.size.height {
            ball.pop_removeAllAnimations()
            animateMessage("Shot")
            resetBall()
            
            return
        }
    }
}

