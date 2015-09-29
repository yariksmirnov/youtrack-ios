//
//  Utils.swift
//  Youtack
//
//  Created by Yarik Smirnov on 28/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Foundation

public struct Utils {
    static public let Domain = "com.yariksmirnov.youtrack-ios"
    
    public enum Code: Int {
        case OperationFailed  = -10000
    }
    
    public static func error(failureReason: String) -> NSError {
        let userInfo = [NSLocalizedFailureReasonErrorKey: failureReason]
        return NSError(domain: Domain, code: Code.OperationFailed.rawValue, userInfo: userInfo)
    }

}