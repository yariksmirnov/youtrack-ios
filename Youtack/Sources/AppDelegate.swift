//
//  AppDelegate.swift
//  Youtack
//
//  Created by Yarik Smirnov on 23/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit
import XCGLogger
import XMLDictionary

let Log = XCGLogger.defaultInstance()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainViewController: MainViewController!
    
    var context: Context = AppContext()
    
    static var instance: AppDelegate {
        get {
            return UIApplication.sharedApplication().delegate as! AppDelegate
        }
    }

    func application(
        application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?)
        -> Bool
    {
        setupLogger()
        setupXMLDictionary()

        mainViewController = window?.rootViewController as! MainViewController
        
        if !context.session.authorized {
            window?.makeKeyAndVisible()
            presentLogin(true)
        }
        
        return true
    }
    
    func presentLogin(onLaunch: Bool = false) {
        guard let loginVC = R.storyboard.login.initialViewController else { return }
        if onLaunch {
            mainViewController.view.addSubview(loginVC.view)
            loginVC.view.frame = mainViewController.view.bounds
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.2 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                self.mainViewController.presentViewController(loginVC, animated: false, completion: nil)
            }
        } else {
            mainViewController.presentViewController(loginVC, animated: true, completion: nil)
        }
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
    
    func setupXMLDictionary() {
        let xmlReader = XMLDictionaryParser.sharedInstance()
        xmlReader.attributesMode = .Unprefixed
        xmlReader.nodeNameMode = .Never
    }
}

