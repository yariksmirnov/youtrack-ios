//
//  Notifications.swift
//  Youtack
//
//  Created by Yarik Smirnov on 29/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Foundation

extension NSNotificationCenter {
    
    static func post(name: String, object: AnyObject? = nil, userInfo: [String: AnyObject!]? = nil) {
        NSNotificationCenter.defaultCenter().postNotificationName(name, object: object, userInfo: userInfo)
    }
}

var NotificationsObserversKey = "NotificationsObserversKey"

extension NSObject {
    
    func subscribe(name: String, action: (NSNotification) -> Void) {
        var observers = objc_getAssociatedObject(self, &NotificationsObserversKey) as? NSMutableDictionary
        if observers == nil {
            observers = NSMutableDictionary()
            objc_setAssociatedObject(self, &NotificationsObserversKey, observers, .OBJC_ASSOCIATION_RETAIN)
        }
        let observer = NSNotificationCenter.defaultCenter().addObserverForName(
            name,
            object: nil,
            queue: NSOperationQueue.mainQueue(),
            usingBlock: action
        )
        observers?[name] = observer
    }
    
    func unsubscribe(name: String) {
        var observers = objc_getAssociatedObject(self, &NotificationsObserversKey) as? [String : AnyObject]
        if observers != nil {
            if let observer = observers![name] {
                NSNotificationCenter.defaultCenter().removeObserver(observer)
                observers![name] = nil
            }
            if observers!.count == 0 {
                objc_setAssociatedObject(self, NotificationsObserversKey, nil, .OBJC_ASSOCIATION_RETAIN)
            }
        }
        NSNotificationCenter.defaultCenter().removeObserver(self, name: name, object: nil)
    }
    
}