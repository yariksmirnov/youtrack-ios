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
    var requiredSSL = true
    
    public static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return NSDictionary.mtl_identityPropertyMapWithModel(self)
    }
    
    func requiredSSLJSONTransformer() -> NSValueTransformer {
        return NSValueTransformer(forName: MTLBooleanValueTransformerName)!
    }
    
    var valid: Bool {
        get {
            return Router(host: self).baseUrl() != nil
        }
    }
}