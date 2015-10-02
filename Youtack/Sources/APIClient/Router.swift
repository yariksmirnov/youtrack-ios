//
//  Router.swift
//  Youtack
//
//  Created by Yarik Smirnov on 01/10/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Foundation

import Alamofire

enum Router: URLRequestConvertible {
    
    case Login(host: Host)
    case CurrentUser()
    
    func restAPI() -> NSURL {
        return Session.active!.host.restAPI()
    }
    
    var URLRequest: NSMutableURLRequest {
        let components: (method: Alamofire.Method, URL: NSURL, query: [String: AnyObject]?) = {
            switch self {
            case .Login(let host):
                return (
                    .POST,
                    host.restAPI().URLByAppendingPathComponent("login"),
                    [ "login" : host.login!, "password" : host.password!]
                )
            case CurrentUser:
                return (
                    .GET,
                    restAPI().URLByAppendingPathComponent("user/current"),
                    nil
                )
            }
        }()
        let mutableURLRequest = NSMutableURLRequest(URL: components.URL)
        mutableURLRequest.HTTPMethod = components.method.rawValue
        return ParameterEncoding.URL.encode(mutableURLRequest, parameters: components.query).0
    }
}