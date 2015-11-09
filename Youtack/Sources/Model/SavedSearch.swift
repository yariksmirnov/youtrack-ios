//
//  SavedSearch.swift
//  Youtack
//
//  Created by Yarik Smirnov on 31/10/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Foundation


public class SavedSearch : Object {
    
    var name: String?
    var query: String?
    
    override public static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return [ "name" : "name", "query" : "__text" ]
    }
}