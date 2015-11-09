//
//  Issue.swift
//  Youtack
//
//  Created by Yarik Smirnov on 10/10/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Foundation
import Mantle

public class Issue: Object {
    var fields = [IssueField]()
    var entityId = ""
    
    public override static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return [
            "id" : "id",
            "fields" : "field",
            "entityId" : "entityId"
        ]
    }
    
    public static func fieldsJSONTransformer() -> NSValueTransformer {
        return MTLJSONAdapter.arrayTransformerWithModelClass(IssueField)
    }
    
    func field(name: String) -> IssueField? {
        for field in fields {
            if field.name == name {
                return field
            }
        }
        return nil
    }
    
    var projectShortName: String? {
        return field("projectShortName")?.stringValue
    }
    
    var numberInProject: Int? {
        return field("numberInProject")?.intValue
    }
    
    var summary: String? {
        return field("summary")?.stringValue
    }
    
    var updaterName: String? {
        return field("updaterName")?.stringValue
    }
    
    var updaterFullName: String? {
        return field("updaterFullName")?.stringValue
    }
    
    var reporterName: String? {
        return field("reporterName")?.stringValue
    }
    
    var reporterFullName: String? {
        return field("reporterFullName")?.stringValue
    }
    
    var commentsCount: Int? {
        return field("commentsCount")?.intValue
    }
    
    var state: String? {
        return field("State")?.stringValue
    }
    
    var type: String? {
        return field("Type")?.stringValue
    }
    
    var priority: IssueField? {
        return field("Priority")
    }
    
    var assignee: User? {
        return field("Assignee")?.userValue
    }
}
