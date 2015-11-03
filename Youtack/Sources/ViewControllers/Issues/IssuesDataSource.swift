//
//  IssuesDataSource.swift
//  Youtack
//
//  Created by Yarik Smirnov on 10/10/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit


class IssuesDataSource : PaginationDataSource<Issue> {
    
    let IssueCellIdentifier = "IssueCell"
    
    required init() {
        let paginator = Paginator<Item>(resource: "issues/")
        super.init(paginator: paginator!)
    }
    
    override func initializeLoader() {
        ContentLoader = { [weak self] completion in
            self?.paginator.load(1) { (issues: [Issue], error) in
                completion() { dataSource in
                    dataSource.items = issues
                    return error
                }
            }
        }
    }
    
    override func registerReusableViews(tableView: UITableView) {
        tableView.registerClass(IssueCell.self, forCellReuseIdentifier: IssueCellIdentifier)
    }
    
    override func cell(indexPath: NSIndexPath, inTableView tableView: UITableView) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier(IssueCellIdentifier)!
    }

    override func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath, withEntity entity: Item) {
        if let issueCell = cell as? IssueCell {
            issueCell.configure(entity)
        }
    }
}