//
//  MainViewController.swift
//  Youtack
//
//  Created by Yarik Smirnov on 28/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit
import UIKit_Material

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = UIColor.whiteColor()
        tabBar.tintColor = UIColor(name: "Blue 500")
    }

}
