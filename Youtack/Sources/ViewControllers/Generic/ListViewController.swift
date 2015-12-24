//
//  ListViewController.swift
//  Youtack
//
//  Created by Yarik Smirnov on 30/10/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit
import Mantle;

public class ListViewController: ViewController, UITableViewDelegate, DataSourceTableViewUpdater {
    
    var tableView: UITableView = UITableView()
    var dataSource: DataSource?
    
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
        tableView.contentInset = UIEdgeInsetsMake(0, 0, tabBarScrollBottomInset(), 0)
    }
    
    func attachDataSource() {
        if context.session.authorized {
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
        dataSource?.tableViewUpdater = self
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
    
    //MARK: DataSourceUpdater
    
    func dataSourceDidReloadData<T, C>(dataSource: BasicDataSource<T, C>) {
        self.tableView.reloadData()
    }
    
    func dataSource<T, C>(dataSource: BasicDataSource<T,C>,
        updateItemAtIndexPath indexPath: NSIndexPath,
        updateAction: (cell: UITableViewCell) -> Void)
    {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            updateAction(cell: cell)
        }
    }
    
}
