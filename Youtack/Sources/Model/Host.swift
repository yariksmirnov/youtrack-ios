//
//  Host.swift
//  Youtack
//
//  Created by Yarik Smirnov on 24/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Alamofire
import Mantle

public class Host: MTLModel, MTLJSONSerializing  {
    var title: String?
    var url: String?
    var login: String?
    var password: String?
    var requiredSSL = true
    
    public static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return NSDictionary.mtl_identityPropertyMapWithModel(self)
    }
    
    func requiredSSLJSONTransformer() -> NSValueTransformer {
        return NSValueTransformer(forName: MTLBooleanValueTransformerName)!
    }
    
    var valid: Bool {
        get { return !(title?.isEmpty ?? true) && !(url?.isEmpty ?? true) && !(login?.isEmpty ?? true) }
    }
    
    public func baseURL() -> NSURL {
        let components = NSURLComponents()
        components.scheme = requiredSSL ? "https" : "http"
        components.host = url
        return components.URL!
    }
    
    public func restAPI() -> NSURL {
        return baseURL().URLByAppendingPathComponent("rest")
    }
    
    public func userURL() -> NSURL {
        return restAPI().URLByAppendingPathComponent("user")
    }
    
    public func currentUserURL() -> NSURL {
        return userURL().URLByAppendingPathComponent("current")
    }
    
    public func loginURL() -> NSURL {
        return userURL().URLByAppendingPathComponent("login")
    }
}