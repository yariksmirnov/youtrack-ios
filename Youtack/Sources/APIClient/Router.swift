//
//  Router.swift
//  Youtack
//
//  Created by Yarik Smirnov on 01/10/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Foundation
import Alamofire

class Router {
    
    var host: Host
    
    init(host: Host) {
        self.host = host
    }
    
    func baseUrl() -> NSURL! {
        let components = NSURLComponents()
        components.scheme = "https"
        components.host = host.url
        return components.URL
    }
    
    func restUrl() -> NSURL {
        return baseUrl().URLByAppendingPathComponent("rest")
    }
    
    func me() -> NSURL {
        return restUrl().URLByAppendingPathComponent("user/current")
    }
    
    func loginUrlRequest(login: String, password: String) -> NSMutableURLRequest {
        let url = restUrl().URLByAppendingPathComponent("user/login")
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = Method.POST.rawValue
        let params = [ "login" : login, "password" : password]
        return ParameterEncoding.URL.encode(request, parameters: params).0
    }
    
    func allProjects() -> NSURL {
        return restUrl().URLByAppendingPathComponent("project/all")
    }
    
}