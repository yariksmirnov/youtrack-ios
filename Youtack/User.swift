//
//  User.swift
//  Youtack
//
//  Created by Yarik Smirnov on 27/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Foundation
import Mantle

public class User: Object {
    static var current: User?
    
    var login: String?
    var fullName: String?
    var email: String?
    var jabber: String?
    var lastAccess: NSDate?
    var groupsUrl: NSURL?
    var roleUrl: NSURL?
    
    
    override public class func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return NSDictionary.mtl_identityPropertyMapWithModel(self)
    }
    
    func groupsUrlJSONTransformer() -> NSValueTransformer {
        return NSValueTransformer(forName: MTLURLValueTransformerName)!
    }
    
    func roleUrlJSONTransformer() -> NSValueTransformer {
        return NSValueTransformer(forName: MTLURLValueTransformerName)!
    }
    
    func lastAccessJSONTransformer() -> NSValueTransformer {
        return MTLValueTransformer(
            usingForwardBlock: { value, success, errorPoiner in
                guard let interval = value as? Double else {
                    success.memory = false
                    return nil
                }
                return NSDate(timeIntervalSince1970: interval / 1000)
            },
            reverseBlock: { value, success, errorPoiner in
                guard let date = value as? NSDate else {
                    success.memory = false
                    return nil
                }
                return date.timeIntervalSince1970 * 1000
            }
        )
    }
}
