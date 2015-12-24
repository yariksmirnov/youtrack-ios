//
//  UIView+Geomerty.swift
//  Tipster
//
//  Created by Yarik Smirnov on 30/11/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Foundation

extension UIView {
    
    var size: CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var newFrame = frame
            newFrame.size = newValue
            frame = newFrame
        }
    }
    
    var origin: CGPoint {
        get {
            return frame.origin
        }
        set(newValue) {
            var newFrame = frame
            newFrame.origin = newValue
            frame = newFrame
        }
    }
    
    var x: CGFloat {
        get {
            return origin.x
        }
        set(newValue) {
            var newOrigin = origin
            newOrigin.x = newValue
            origin = newOrigin
        }
    }
    
    var y: CGFloat {
        get {
            return origin.y
        }
        set(newValue) {
            var newOrigin = origin
            newOrigin.y = newValue
            origin = newOrigin
        }
    }
    
    var width: CGFloat {
        get {
            return size.width
        }
        set(newValue) {
            var newFrame = frame
            newFrame.size.width = newValue
            frame = newFrame
        }
    }
    
    var height: CGFloat {
        get {
            return size.height
        }
        set(newValue) {
            var newFrame = frame
            newFrame.size.height = newValue
            frame = newFrame
        }
    }
    
    var bottom: CGFloat {
        get {
            return origin.y + height
        }
        set(newValue) {
            y = newValue - height
        }
    }
    
    var maxY: CGFloat {
        get {
            return frame.maxY
        }
        set(newValue) {
            var newOrigin = origin
            newOrigin.y = newValue - height
            origin = newOrigin
        }
    }
    
}