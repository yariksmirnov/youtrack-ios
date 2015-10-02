//
//  NavigationController.swift
//  Youtack
//
//  Created by Yarik Smirnov on 30/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return topViewController
    }
    
    override func childViewControllerForStatusBarHidden() -> UIViewController? {
        return topViewController
    }
}
