//
//  Object.swift
//  Youtack
//
//  Created by Yarik Smirnov on 27/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Mantle

public class Object: MTLModel, MTLJSONSerializing {
    var id: String = ""
    
    public class func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return Dictionary()
    }
}
