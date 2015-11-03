//
//  BasicAdapter.swift
//  Youtack
//
//  Created by Yarik Smirnov on 30/10/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit

class BasicAdapter : DataSourceTableViewUpdater {
    
    var tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func dataSourceDidReloadData<T>(dataSource: BasicDataSource<T>) {
        self.tableView.reloadData()
    }
    
    func dataSource<T>(dataSource: BasicDataSource<T>,
        updateItemAtIndexPath indexPath: NSIndexPath, 
        updateAction: (cell: UITableViewCell) -> Void)
    {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            updateAction(cell: cell)
        }
    }
}