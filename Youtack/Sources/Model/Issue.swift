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
        get { return field("projectShortName")?.stringValue }
    }
    
    var numberInProject: Int? {
        get { return field("numberInProject")?.intValue }
    }
    
    var summary: String? {
        get { return field("summary")?.stringValue }
    }
    
    var updaterName: String? {
        get { return field("updaterName")?.stringValue }
    }
    
    var updaterFullName: String? {
        get { return field("updaterFullName")?.stringValue }
    }
    
    var reporterName: String? {
        get { return field("reporterName")?.stringValue }
    }
    
    var reporterFullName: String? {
        get { return field("reporterFullName")?.stringValue }
    }
    
    var commentsCount: Int? {
        get { return field("commentsCount")?.intValue }
    }
    
    var state: String? {
        get { return field("State")?.stringValue }
    }
    
    var type: String? {
        get { return field("Type")?.stringValue }
    }
    
    var priority: String? {
        get { return field("Priority")?.stringValue }
    }
    
    var assignee: User? {
        get { return field("Assignee")?.userValue }
    }
}
