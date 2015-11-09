//
//  ListViewController.swift
//  Youtack
//
//  Created by Yarik Smirnov on 30/10/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit
import Mantle;

public class ListViewController: ViewController, UITableViewDelegate {
    
    var tableView: UITableView = UITableView()
    var dataSource: DataSource?
    var dataSourceAdapter: BasicAdapter?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        layoutView()
        
        subscribe(Session.SessionDidAuthorizeNotification) { notification in
            if self.dataSource == nil {
                self.attachDataSource()
                self.dataSource?.loadContent(false)
            }
        }
        subscribe(Session.SessionDidCloseNotification) { notification in
            if self.dataSource != nil {
                self.resetDataSource()
            }
        }
    }
    
    override public func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if dataSource == nil {
            attachDataSource()
        }
        dataSource?.loadContent(false)
    }
    
    public override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func layoutView() {
        layoutTableView()
    }
    
    func layoutTableView() {
        view.insertSubview(tableView, atIndex: 0)
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor(gray: 236)
        tableView.separatorStyle = .None
    }
    
    func attachDataSource() {
        if Session.active != nil {
            if let ds = self.buildDataSource() {
                dataSource = ds
                configureDataSource()
            }
        }
    }
    
    func buildDataSource() -> DataSource? {
        return nil
    }
    
    func configureDataSource() {
        dataSourceAdapter = BasicAdapter(tableView: tableView)
        dataSource?.tableViewUpdater = dataSourceAdapter
        tableView.dataSource = dataSource
        dataSource?.registerReusableViews(tableView)
    }
    
    func resetDataSource() {
        tableView.dataSource = nil
        dataSource?.reset()
        tableView.reloadData()
    }
    
    override func addCustomNavigationBar(height: CGFloat = 64) {
        super.addCustomNavigationBar(height)
        automaticallyAdjustsScrollViewInsets = false
        tableView.contentInset = UIEdgeInsetsMake(height, 0, tabBarScrollBottomInset(), 0)
        tableView.separatorInset = tableView.contentInset
    }
    
    func tabBarScrollBottomInset() -> CGFloat
    {
        let mainVC = AppDelegate.instance.mainViewController
        let tabBarHeight = mainVC.tabBar.bounds.size.height
        if (self.navigationController != nil && mainVC.viewControllers!.contains(self.navigationController!)) ||
            mainVC.viewControllers!.contains(self)
        {
            return tabBarHeight
        }
        return 0
    }
}
