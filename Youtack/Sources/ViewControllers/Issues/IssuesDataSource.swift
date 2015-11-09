//
//  IssuesDataSource.swift
//  Youtack
//
//  Created by Yarik Smirnov on 10/10/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit


class IssuesDataSource : PaginationDataSource<Issue, IssueCell> {
    
    required init(searchQuery: String) {
        let paginator = Paginator<Item>(resource: "issue/", query: ["filter" : searchQuery])
        super.init(paginator: paginator!)
        CellIdentifier = R.nib.issueCell.reuseIdentifier.identifier
    }
    
    override func registerReusableViews(tableView: UITableView) {
        tableView.registerNib(
            R.nib.issueCell.instance,
            forCellReuseIdentifier: R.nib.issueCell.reuseIdentifier.identifier
        )
    }
    
}