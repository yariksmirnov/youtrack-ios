//
//  DropDownListAnimator.swift
//  Youtack
//
//  Created by Yarik Smirnov on 24/12/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Foundation


class DropDownListAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var dismissing: Bool
    
    init(dismissing: Bool = false) {
        self.dismissing = dismissing
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.25
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        var vc = transitionContext
            .viewControllerForKey(UITransitionContextToViewControllerKey) as! ListViewController
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let navigationBar = fromVC.navigationController?.navigationBar
        if dismissing {
            vc = transitionContext
                .viewControllerForKey(UITransitionContextFromViewControllerKey) as! ListViewController
        } else {
            let container = transitionContext.containerView()!
            vc.view.frame = container.bounds
            vc.view.height -= navigationBar?.maxY ?? 0
            container.addSubview(vc.view)
        }
        vc.tableView.height = min(
            vc.view.height,
            CGFloat(vc.tableView.numberOfRowsInSection(0)) * vc.tableView.rowHeight
        )
        if !dismissing {
            vc.view.bottom = 0
        }
        let duration = transitionDuration(transitionContext)
        UIView.animateWithDuration(
            duration,
            animations: {
                if self.dismissing {
                    vc.view.bottom = 0
                } else {
                    vc.view.y = navigationBar?.maxY ?? 0
                }
            },
            completion: { finished in
                if self.dismissing {
                    vc.view.removeFromSuperview()
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            }
        )
    }
}
