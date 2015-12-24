//
//  Session.swift
//  Youtack
//
//  Created by Yarik Smirnov on 24/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Alamofire
import Observable
import KeychainAccess

public class Session {
    
    static let SessionDidAuthorizeNotification = "SessionDidAuthorizeNotification"
    static let SessionDidCloseNotification = "SessionDidCloseNotification"
    
    var host: Host?
    var keychain = Keychain(service: NSBundle.mainBundle().bundleIdentifier!)
    
    init() {
        restoreAuthorization()
    }
    
    public func restoreAuthorization() -> Bool {
        guard let data = self.keychain[data: "host"] else { return false }
        self.host = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? Host
        if authorized {
            NSNotificationCenter.post(Session.SessionDidAuthorizeNotification, object: self)
            return true
        }
        return false
    }
    
        
    var authorized: Bool {
        get {
            guard let host = host else { return false }
            let baseUrl = Router(host: host).baseUrl()
            if let cookies = NSHTTPCookieStorage.sharedHTTPCookieStorage().cookiesForURL(baseUrl) {
                for cookie in cookies {
                    if cookie.expiresDate?.compare(NSDate()) == .OrderedDescending {
                        return true
                    }
                }
            }
            return false
        }
    }
    
    func authorize(host: Host, headers: [String: String]) -> Bool {
        let cookies = NSHTTPCookie.cookiesWithResponseHeaderFields(
            headers,
            forURL: Router(host: host).baseUrl()
        )
        if let authCookie = cookies.first {
            NSHTTPCookieStorage.sharedHTTPCookieStorage().setCookie(authCookie)
            self.host = host
            let data = NSKeyedArchiver.archivedDataWithRootObject(host)
            keychain[data: "host"] = data
            return true
        }
        return false
    }
}



