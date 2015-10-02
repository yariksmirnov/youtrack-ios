//
//  UserAPI.swift
//  Youtack
//
//  Created by Yarik Smirnov on 27/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Alamofire

public class UserAPI: APIClient {
    
    public func getCurrentUser(completion:((user: User?, error: NSError?) -> Void)?) {
        currentRequest = request(Router.CurrentUser())
            .validate()
            .responseObject() { (request, response, result: Result<User>)  in
                switch result {
                case .Success(let user):
                    completion?(user: user, error: nil)
                case .Failure(_, let error):
                    completion?(user: nil, error: error as NSError)
                }
        }
    }
    
}