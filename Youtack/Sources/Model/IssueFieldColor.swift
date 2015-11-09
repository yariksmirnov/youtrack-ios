//
//  IssueFieldColor.swift
//  Youtack
//
//  Created by Yarik Smirnov on 09/11/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Foundation
import Mantle

class IssueFieldColor: Object {
    var background: UIColor?
    var foreground: UIColor?
    
    override static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return [ "background" : "bg", "foreground" : "fg" ]
    }
    
    static func JSONTransformerForKey(key: String!) -> NSValueTransformer! {
        if key == "background" || key == "foreground" {
            return MTLValueTransformer(usingForwardBlock: { value, success, errorPointer in
                guard value is String else {
                    return nil
                }
                var hex = value as! String
                if !hex.isEmpty && hex.characters.first == "#" {
                    hex = hex.substringFromIndex(hex.startIndex.successor())
                }
                return UIColor(hexString: hex)
            })
        }
        return nil
    }
}