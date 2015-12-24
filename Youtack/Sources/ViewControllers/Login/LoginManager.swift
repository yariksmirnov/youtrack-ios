//
//  LoginManager.swift
//  Youtack
//
//  Created by Yarik Smirnov on 19/12/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Foundation
import Observable

class LoginManager {
    
    var authApi = AuthAPI()
    var context: Context
    
    init(context: Context) {
        self.context = context
    }
    
    func signIn(host: Host, 
        login: String, 
        password: String, 
        completion: (success: Bool, error: NSError?) -> Void)
    {
        guard host.valid else {
            completion(success: false, error: nil)
            return
        }
        authApi.login(host, login: login, password: password) { [unowned self] headers, error in
            guard error == nil, let authHeaders = headers else {
                completion(success: false, error: error)
                return
            }
            self.context.session.authorize(host, headers: authHeaders)
            if self.context.session.authorized {
                UserAPI().getCurrentUser { user, error in
                    guard error == nil, let current = user else { return }
                    User.current ^= current
                }
            }
            completion(success: self.context.session.authorized, error: error)
        }
    }
    
}