//
//  Session.swift
//  Youtack
//
//  Created by Yarik Smirnov on 24/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Alamofire
import Observable

public class Session {
    
    public static var active: Session?
    
    let host: Host
    
    init(host: Host) {
        self.host = host
    }
    
    public static func restoreAuthorization(host: Host) -> Bool {
        let session = Session(host: host)
        if session.authorized {
            active = session
            active?.loadCurrentUserInfo()
            print("Restored authorization for host: \(host)")
            return true
        }
        return false
    }
    
    public func login(completion: ((success: Bool) -> Void)? = nil) {
        request(
            .POST,
            host.loginURL(),
            parameters: ["login" : host.login!, "password" : host.password!])
            .validate()
            .responseString { request, response, result in
                print(response)
                switch result {
                case .Success(_):
                    if let headers = response?.allHeaderFields as? [String : String] {
                        do {
                            try self.authorize(headers)
                            self.loadCurrentUserInfo()
                            completion?(success: true)
                            return
                        } catch {
                            //no-opt
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
    
    func authorize(headers: [String: String]) throws {
        let cookies = NSHTTPCookie.cookiesWithResponseHeaderFields(
            headers,
            forURL: host.baseURL()
        )
        if let authCookie = cookies.first {
            NSHTTPCookieStorage.sharedHTTPCookieStorage().setCookie(authCookie)
            Session.active = self
            return
        }
    }
    
    func loadCurrentUserInfo() {
        let api = UserAPI()!
        api.getCurrentUser { (user, error) -> Void in
            User.current = Observable(user)
        }
    }
    
}



