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
        navigationBar?.tintColor = UIColor.whiteColor()
        navigationBar?.titleTextAttributes = [
            NSFontAttributeName : R.font.robotoBold(size: 17)!,
            NSForegroundColorAttributeName : UIColor.whiteColor()
        ]
        UINavigationBar.appearance().backIndicatorImage = R.image.navBarBack
    }
    
    func updateNavigationBarVisibility(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    func updateBarButtonItems(animated: Bool) {
        let isInNavigation = self.navigationController != nil
        let isFirstInNavigation = self.navigationController?.viewControllers.first == self
        if isInNavigation && !isFirstInNavigation {
            navigationItem.leftBarButtonItems = [customBackButtonItem]
        }
        if navItem != nil {
            navItem?.leftBarButtonItems = navigationItem.leftBarButtonItems
            navigationItem.leftBarButtonItems = nil
        }
    }
    
    lazy var customBackButtonItem: UIBarButtonItem = UIBarButtonItem(
        image: R.image.ic_arrow_back_36pt,
        style: .Plain,
        target: self,
        action: "onBack"
    )
    
    func onBack() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
