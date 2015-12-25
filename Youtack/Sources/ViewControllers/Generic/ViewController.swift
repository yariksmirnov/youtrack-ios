//
//  ViewController.swift
//  Youtack
//
//  Created by Yarik Smirnov on 30/10/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit

public class ViewController: UIViewController {
    
    var navigationBar: UINavigationBar?
    var navItem: UINavigationItem?
    
    lazy var context: Context = {
        return AppDelegate.instance.context
    }()

    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateNavigationBarVisibility(animated)
        updateBarButtonItems(animated)
    }
    
    func addCustomNavigationBar(height: CGFloat = 64.0) {
        navigationBar = UINavigationBar(frame: CGRect(x: 0.0, y: 0.0, width: view.bounds.size.width, height: height))
        view.addSubview(navigationBar!)
        navigationBar?.autoresizingMask = [.FlexibleWidth, .FlexibleBottomMargin]
        navItem = UINavigationItem()
        navigationBar?.items = [navItem!]
    }
    
    func defaultContentInsets() -> UIEdgeInsets {
        var insets = UIEdgeInsets()
        if let tabBar = tabBarController?.tabBar {
            insets.bottom = tabBar.height
        }
        if let customNavBar = navigationBar {
            insets.top = customNavBar.height
        }
        return insets
    }
    
    func updateNavigationBarVisibility(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    func updateBarButtonItems(animated: Bool) {
    }
    
    func onBack() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
