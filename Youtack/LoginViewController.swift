//
//  UIViewController.swift
//  Youtack
//
//  Created by Yarik Smirnov on 27/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var loginTextField: UITextField?
    @IBOutlet var passwordTextField: UITextField?
    @IBOutlet var signInButton: UIButton?
    
    var session: Session?
    var host: Host? {
        didSet {
            if host != nil {
                session = Session(host: host!)
            }
        }
    }
    
    override func viewDidLoad() {
        title = host?.title
    }
    
    @IBAction func onLogin() {
        session?.login((loginTextField?.text)!, password: (passwordTextField?.text)!) { success in
            if success {
                let api = UserAPI()!
                api.getCurrentUser() { user, error in
                    
                }
            }
        }
    }
    
}
