//
//  Notifications.swift
//  Youtack
//
//  Created by Yarik Smirnov on 29/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Foundation

extension NSNotificationCenter {
    
    static func postNotification(name: String, userInfo: [String: AnyObject!]? = nil) {
        NSNotificationCenter.defaultCenter().postNotificationName(name, object: nil, userInfo: userInfo)
    }
}

var NotificationsObserversKey = "NotificationsObserversKey"

extension NSObject {
    
    func subscribeForNotification(name: String, action: (NSNotification) -> Void) {
        var observers = objc_getAssociatedObject(self, &NotificationsObserversKey) as? [String: AnyObject]
        if observers == nil {
            observers = [String: AnyObject]()
            objc_setAssociatedObject(self, &NotificationsObserversKey, observers, .OBJC_ASSOCIATION_RETAIN)
        }
        let observer = NSNotificationCenter.defaultCenter().addObserverForName(
            name,
            object: self,
            queue: NSOperationQueue.currentQueue(),
            usingBlock: action
        )
        observers?[name] = observer
    }
    
}