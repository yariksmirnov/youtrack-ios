//
//  AuthAPI.swift
//  Youtack
//
//  Created by Yarik Smirnov on 19/12/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Foundation
import Alamofire

class AuthAPI: APIClient {
    
    func login(host: Host,
        login: String,
        password: String,
        completion: (([String: String]?, NSError?) -> Void))
    {
        request(Router(host: host).loginUrlRequest(login, password: password))
            .validate()
            .responseString { request, response, result in
                switch result {
                case .Success(_):
                    if let headers = response?.allHeaderFields as? [String : String] {
                        completion(headers, nil)
                    }
                case .Failure(_, _): break
                }
            }
            .responseError { error in
                completion(nil, error)
        }
    }

    
}