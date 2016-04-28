//
//  EventDetailsTransitionDelegate.swift
//  GPSTrack
//
//  Created by Albert Zhang on 4/8/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import UIKit

class EventEditTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private static let DURATION = 0.6

    private var isPresenting:Bool

    private var animator:UIDynamicAnimator?

    init(isPresenting:Bool) {
        self.isPresenting = isPresenting
        super.init()
        printInit(self)
    }

    deinit {
        printDeinit(self)
    }

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return EventEditTransitionAnimator.DURATION
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()!

        if isPresenting {
            let sz = fromViewController.view.frame.size

            let targetSz = CGSize(width: sz.width * 0.8, height: sz.height * 0.618)
            let targetF = CGRect(x: (sz.width - targetSz.width) * 0.5,
                                 y: -targetSz.height, //(sz.height - targetSz.height) * 0.5
                                 width: targetSz.width,
                                 height: targetSz.height)
            toViewController.view.frame = targetF

            containerView.addSubview(toViewController.view)

            animator = UIDynamicAnimator(referenceView: containerView)

            let snapBehavior = UISnapBehavior(item: toViewController.view,
                                              snapToPoint: fromViewController.view.center)
            snapBehavior.damping = 0.8
            animator?.addBehavior(snapBehavior)

            let resistBehavior = UIDynamicItemBehavior(items: [toViewController.view])
            resistBehavior.resistance = 2;
            animator?.addBehavior(resistBehavior)

            dispatch_after_second(EventEditTransitionAnimator.DURATION) {
                transitionContext.completeTransition(true)
            }

        } else {
            animator = UIDynamicAnimator(referenceView: containerView)

            let sz = containerView.bounds.size
            let snapBehavior = UISnapBehavior(item: fromViewController.view,
                                              snapToPoint: CGPoint(x: sz.width * 0.6, y: sz.height * 1.5))
            snapBehavior.damping = 1.1
            animator?.addBehavior(snapBehavior)

            let resistBehavior = UIDynamicItemBehavior(items: [fromViewController.view])
            resistBehavior.resistance = 4;
            animator?.addBehavior(resistBehavior)

            dispatch_after_second(EventEditTransitionAnimator.DURATION) {
                fromViewController.view.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
        }
    }

    func animationEnded(transitionCompleted: Bool) {

    }
}
