//
//  MainViewController.swift
//  Youtack
//
//  Created by Yarik Smirnov on 28/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit
import MaterialDesignColor
import BFPaperTabBarController

class MainViewController: BFPaperTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeAppearence()
        
        tabBar.barTintColor = UIColor.whiteColor()
        tabBar.tintColor = MaterialDesignColor.blue500
    }
    
    func initializeAppearence() {
        let titleAttribs: [String:AnyObject] = [
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "Roboto-Medium", size: 20)!
        ]
        UINavigationBar.appearance().titleTextAttributes = titleAttribs
    }
}
