//
//  DashboardViewController.swift
//  Youtack
//
//  Created by Yarik Smirnov on 30/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit
import MaterialDesignColor

public class DashboardViewController: ListViewController {
    
    var searchesDataSource: SavedSearchesDataSource? {
        get { return dataSource as? SavedSearchesDataSource }
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        addCustomNavigationBar()
        navItem?.title = "Dashboard".uppercaseString
        self.navigationBar!.barTintColor = MaterialDesignColor.blue500
    }
    
    override func layoutTableView() {
        super.layoutTableView()
        tableView.autoPinEdgesToSuperviewEdges()
        tableView.estimatedRowHeight = 48
    }
    
    override func buildDataSource() -> DataSource? {
        return SavedSearchesDataSource()
    }
    
    //MARK: TableViewDelegate
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let search = searchesDataSource?.item(indexPath) {
            let issuesVC = IssuesListViewController(savedSearch: search)
            navigationController?.pushViewController(issuesVC, animated: true)
        }
    }
}
