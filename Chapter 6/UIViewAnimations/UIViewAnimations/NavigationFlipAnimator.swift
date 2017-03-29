//
//  NavigationFlipAnimator.swift
//  UIViewAnimations
//
//  Created by Hossam Ghareeb on 9/20/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

class NavigationFlipAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    var navigationOperation: UINavigationControllerOperation = .push
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 3.0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if let fromView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)?.view, let toView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)?.view {
            
            let direction: UIViewAnimationOptions = self.navigationOperation == .push ? .transitionFlipFromLeft : .transitionFlipFromRight
            UIView.transition(from: fromView, to: toView, duration: 3.0, options: direction, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        }
    }
}
