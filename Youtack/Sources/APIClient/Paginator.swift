//
//  Paginator.swift
//  Youtack
//
//  Created by Yarik Smirnov on 30/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Foundation

import Alamofire
import Mantle
import ExSwift

public class Paginator<T: MTLJSONSerializing> {
    
    var limit: Int = 20
    var offset: Int = 0
    var resource: String
    var query: [String : AnyObject]?
    var session: Session
    
    public typealias PaginatorResponseHandler = ([T], NSError?) -> Void
    
    init(session: Session, resource: String, query: [String: AnyObject]? = nil, limit: Int = 20) {
        self.session = session
        self.resource = resource
        self.query = query
        self.limit = limit
    }
    
    convenience init?(resource: String, query: [String: AnyObject]? = nil) {
        guard let session = Session.active else {
            return nil
        }
        self.init(session: session, resource: resource, query: query)
    }
    
    public func load(page: Int = 1, completion: PaginatorResponseHandler? = nil) {
        let url = session.host.restAPI().URLByAppendingPathComponent(resource)
        let parameters = [
            "limit" : limit,
            "offset" : offsetFromPage(page)
        ]
        if query != nil {
            parameters | query!
        }
        request(.GET, url, parameters: parameters).responseArray() { (request, response, result: Result<[T]>) in
            switch result {
            case .Success(let array):
                completion?(array, nil)
            case .Failure(_, let error):
                Log.error((error as NSError).description)
                completion?([], error as NSError)
            }
        }
    }
    
    func offsetFromPage(page: Int) -> Int {
        guard page >= 1 else {
            return 0;
        }
        return limit * (page - 1);
    }
    
}