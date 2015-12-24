//
//  LoginViewController.swift
//  Youtack
//
//  Created by Yarik Smirnov on 19/12/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit

class LoginViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet var hostUrlTextField: UITextField!
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    lazy var loginManager = {
        return LoginManager(context: AppDelegate.instance.context)
    }()
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func onSignIn() {
        let host = Host()
        host.url = hostUrlTextField.text
        guard let login = loginTextField.text,
              let password = passwordTextField.text where
              host.valid else {
                return
        }
        loginManager.signIn(host, login: login, password: password) { [unowned self] success, error in
            guard error == nil else {
                let alertVC = UIAlertController(
                    title: "Login Error", 
                    message: error!.localizedFailureReason,
                    preferredStyle: .Alert
                )
                alertVC.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
                self.presentViewController(alertVC, animated: true, completion: nil)
                return
            }
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
}
