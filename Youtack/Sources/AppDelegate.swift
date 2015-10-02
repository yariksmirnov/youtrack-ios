//
//  AppDelegate.swift
//  Youtack
//
//  Created by Yarik Smirnov on 23/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit
import XCGLogger

let Log = XCGLogger.defaultInstance()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainViewController: MainViewController!
    

    func application(
        application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?)
        -> Bool
    {
        setupLogger()

        mainViewController = window?.rootViewController as! MainViewController
        HostsManager.instance.loadConfiguredHosts()
        return true
    }
    
    func setupLogger() {
        Log.xcodeColorsEnabled = true
        Log.xcodeColors = [
            .Verbose: XCGLogger.XcodeColor(fg: UIColor(hexRGB: 0x555555)),
            .Debug: .black,
            .Info: XCGLogger.XcodeColor(fg: UIColor(hexRGB: 0x00007F)),
            .Warning: XCGLogger.XcodeColor(fg: UIColor(hexRGB: 0xFFA500)),
            .Error: XCGLogger.XcodeColor(fg: UIColor(hexRGB: 0xcc0000)),
            .Severe: XCGLogger.XcodeColor(fg: UIColor(hexRGB: 0xff0000))
        ]
        Log.setup(
            .Verbose,
            showLogIdentifier: false,
            showFunctionName: false,
            showThreadName: false,
            showLogLevel: true,
            showFileNames: true,
            showLineNumbers: true,
            showDate: true,
            writeToFile: false,
            fileLogLevel: nil
        )
    }
}

