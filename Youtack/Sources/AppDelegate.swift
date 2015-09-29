//
//  AppDelegate.swift
//  Youtack
//
//  Created by Yarik Smirnov on 23/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainViewController: MainViewController!
    

    func application(application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?
        ) -> Bool
    {   
        mainViewController = window?.rootViewController as! MainViewController
        HostsManager.instance.loadConfiguredHosts()
        return true
    }
}

