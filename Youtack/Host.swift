//
//  Host.swift
//  Youtack
//
//  Created by Yarik Smirnov on 24/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Alamofire
import Mantle

public class Host: MTLModel, MTLJSONSerializing {
    var title: String?
    var url: String?
    var requiredSSL = true
    
    public static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return [
            "title" : "title",
            "url" : "url",
            "requredSSL" : "required_ssl"
        ]
    }
    
    func requiredSSLJSONTransformer() -> NSValueTransformer {
        return NSValueTransformer(forName: MTLBooleanValueTransformerName)!
    }
    
    var valid: Bool {
        get {
            return title?.characters.count > 0 && url?.characters.count > 0
        }
    }
    
    //MARK: URLStringConvertible
    
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
    
    public func login() -> NSURL {
        return userURL().URLByAppendingPathComponent("login")
    }
    
}