//
//  UserAPI.swift
//  Youtack
//
//  Created by Yarik Smirnov on 27/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Alamofire

public class UserAPI: APIClient {
    
    public func getCurrentUser(completion:((user: User, error: NSError?) -> Void)?) {
        currentRequest = request(
            .GET,
            session.host.currentUserURL()
        )
        currentRequest?.responseObject() { (request, response, result: Result<User>)  in
            switch result {
            case .Success(let user):
                debugPrint(user)
            case .Failure(_, let error):
                debugPrint(error)
            }
        }
    }
    
}