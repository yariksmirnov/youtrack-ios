//
//  IssueField.swift
//  Youtack
//
//  Created by Yarik Smirnov on 07/11/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Foundation
import Mantle

class IssueField: Object {
    var name: String?
    var value: AnyObject?
    var color: IssueFieldColor?
    var type: String?
    
    override static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return [
            "name" : "name",
            "value" : "value",
            "color" : "color",
            "type" : "xsi:type"
        ]
    }
    
    var stringValue: String? {
        return value as? String
    }
    
    var intValue: Int? {
        return value as? Int
    }
    
    var doubleValue: Double? {
        return value as? Double
    }
    
    var rawDictionaryValue: [String:AnyObject]? {
        return value as? [String: AnyObject]
    }
    
    lazy var userValue: User? = {
        if let dictionary = self.rawDictionaryValue {
            return try! MTLJSONAdapter(modelClass: User.self)
                .modelFromJSONDictionary(dictionary) as? User
        }
        return nil
    }()
    
    lazy var dateValue: NSDate? = {
        if let timestamp = self.doubleValue {
            return NSDate(timeIntervalSince1970: timestamp)
        }
        return nil
    }()
    
    lazy var attachmentValue: Attachment? = {
        if let dictionary = self.rawDictionaryValue {
            return try! MTLJSONAdapter(modelClass: Attachment.self)
                .modelFromJSONDictionary(dictionary) as? Attachment
        }
        return nil
    }()
}