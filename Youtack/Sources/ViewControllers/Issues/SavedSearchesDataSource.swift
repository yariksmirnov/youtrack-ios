//
//  SavedSearchesDataSource.swift
//  Youtack
//
//  Created by Yarik Smirnov on 31/10/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit


public class SavedSearchesDataSource : PaginationDataSource<SavedSearch> {
    
    let SavedSearchCellIdentifier = "SavedSearchCell"
    
    init() {
        let paginator = Paginator<SavedSearch>(resource: "user/search")
        super.init(paginator: paginator!)
    }
    
    override func registerReusableViews(tableView: UITableView) {
        tableView.registerClass(SavedSearchCell.self, forCellReuseIdentifier: SavedSearchCellIdentifier)
    }
    
    override func cell(indexPath: NSIndexPath, inTableView tableView: UITableView) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier(SavedSearchCellIdentifier, forIndexPath: indexPath)
    }
    
    override func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath, withEntity entity: Item) {
        (cell as? SavedSearchCell)?.configure(entity)
    }
}