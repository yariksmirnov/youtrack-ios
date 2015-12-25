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
        tableView.contentInset = defaultContentInsets()
        tableView.scrollIndicatorInsets = defaultContentInsets()
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
