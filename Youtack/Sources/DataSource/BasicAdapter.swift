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