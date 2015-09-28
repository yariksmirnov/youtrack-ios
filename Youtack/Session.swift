//
//  Session.swift
//  Youtack
//
//  Created by Yarik Smirnov on 24/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Alamofire

public class Session {
    
    public static var active: Session?;
    
    let host: Host
    
    init(host: Host) {
        self.host = host
    }
    
    public func login(username: String, password: String, completion: ((success: Bool) -> Void)?) {
        request(
            .POST,
            host.login(),
            parameters: ["login" : username, "password" : password])
            .validate()
            .responseString { request, response, result in
                print(response)
                switch result {
                case .Success(_):
                    if let headers = response?.allHeaderFields as? [String : String] {
                        let cookies = NSHTTPCookie.cookiesWithResponseHeaderFields(
                            headers,
                            forURL: self.host.baseURL()
                        )
                        if let authCookie = cookies.first {
                            NSHTTPCookieStorage.sharedHTTPCookieStorage().setCookie(authCookie)
                            Session.active = self
                            completion?(success: true)
                            return
                        }
                    }
                    completion?(success: false)
                case .Failure(let failureData, let error):
                    if let data = failureData {
                        print("Login Failed: \(NSString(data: data, encoding: NSUTF8StringEncoding)!) \(error)")
                    }
                    completion?(success: false)
                }
        }
    }
    
    var authorized: Bool {
        get {
            if let cookies = NSHTTPCookieStorage.sharedHTTPCookieStorage().cookiesForURL(host.baseURL()) {
                for cookie in cookies {
                    if cookie.expiresDate?.compare(NSDate()) == .OrderedDescending {
                        return true
                    }
                }
            }
            return false
        }
    }
    
}



