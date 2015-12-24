//
//  UIView+Tipster.swift
//  Tipster
//
//  Created by Yarik Smirnov on 24/11/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Foundation
import PureLayout

extension UIView {
    
    func findFirstResponder() -> UIView? {
        if self.isFirstResponder() {
            return self
        }
        for view in subviews {
            if let responder = view.findFirstResponder() {
                return responder
            }
        }
        return nil
    }
    
}