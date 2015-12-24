//
//  Project.swift
//  Youtack
//
//  Created by Yarik Smirnov on 24/12/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

class Project: Object {
    
    var name: String = ""
    
    override static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return [
            "name" : "name",
            "id" : "shortName"
        ]
    }
    
}
