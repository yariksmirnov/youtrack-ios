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
    
    var user: User?
    var date: NSDate?
    var attachment: Attachment?
    
    override static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return NSDictionary.mtl_identityPropertyMapWithModel(self)
    }
    
    var stringValue: String? {
        get { return value as? String }
    }
    
    var intValue: Int? {
        get { return value as? Int }
    }
    
    var doubleValue: Double? {
        get { return value as? Double }
    }
    
    var rawDictionaryValue: [String:AnyObject]? {
        get { return value as? [String: AnyObject] }
    }
    
    var userValue: User? {
        get {
            if user != nil {
                return user
            }
            if let dictionary = rawDictionaryValue {
                try! user = MTLJSONAdapter().modelFromJSONDictionary(dictionary) as? User
            }
            return user
        }
    }
    
    var dateValue: NSDate? {
        get {
            if date != nil {
                return date
            }
            if let timestamp = doubleValue {
                date = NSDate(timeIntervalSince1970: timestamp)
            }
            return date
        }
    }
    
    var attachmentValue: Attachment? {
        get {
            if attachment != nil {
                return attachment
            }
            if let dictionary = rawDictionaryValue {
                try! attachment = MTLJSONAdapter().modelFromJSONDictionary(dictionary) as? Attachment
            }
            return attachment
        }
    }
}