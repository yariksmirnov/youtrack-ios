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

class Paginator<T: MTLJSONSerializing>: APIClient {
    
    var limit: Int = 20
    var offset: Int = 0
    var resource: String
    var query: [String : AnyObject]?
    
    typealias PaginatorResponseHandler = ([T], NSError?) -> Void
    
    required init(resource: String, query: [String: AnyObject]? = nil, limit: Int = 20) {
        self.resource = resource
        super.init(session: AppDelegate.instance.context.session)
        self.query = query
        self.limit = limit
    }
    
    func load(page: Int = 1, completion: PaginatorResponseHandler? = nil) {
        guard let url = router?.restUrl().URLByAppendingPathComponent(resource) else { return }
        var parameters = [
            "limit" : limit,
            "offset" : offsetFromPage(page)
        ] as [String: AnyObject]
        if query != nil {
            parameters = parameters | query!
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