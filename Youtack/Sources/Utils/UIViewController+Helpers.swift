//
//  UIViewController+Tipster.swift
//  Tipster
//
//  Created by Yarik Smirnov on 24/11/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Foundation


extension UIViewController {
    
    var currentFirstResponder: UIResponder? {
        return view.findFirstResponder()
    }
    
    func resignResponderAndWait(completion: (() -> Void)? = nil) {
        if let responder = currentFirstResponder {
            responder.resignFirstResponder()
            if completion != nil {
                let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.6 * Double(NSEC_PER_SEC)))
                dispatch_after(delayTime, dispatch_get_main_queue()) {
                    completion?()
                }
            }
        } else {
            completion?()
        }
    }
    
    func presentAfterResign(viewControllerToPresent: UIViewController,
        animated: Bool, 
        completion: (() -> Void)? = nil)
    {
        resignResponderAndWait {
            self.presentViewController(viewControllerToPresent, animated: animated, completion: completion)
        }
    }
    
    func presentAfterDismiss(viewControllerToPresent: UIViewController,
        viewControllerToDismiss: UIViewController, 
        presentCompletion: (() -> Void)? = nil, 
        dismissCompletion: (() -> Void)? = nil)
    {
        if viewControllerToDismiss.presentingViewController != nil {
            viewControllerToDismiss.dismissViewControllerAnimated(true) {
                dismissCompletion?()
                self.presentViewController(
                    viewControllerToPresent,
                    animated: true, 
                    completion: presentCompletion)
            }
        } else {
            dismissCompletion?()
            self.presentViewController(
                viewControllerToPresent,
                animated: true,
                completion: presentCompletion)
        }
    }
}