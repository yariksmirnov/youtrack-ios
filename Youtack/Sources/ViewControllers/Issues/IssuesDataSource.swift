//
//  IssuesDataSource.swift
//  Youtack
//
//  Created by Yarik Smirnov on 10/10/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit


class IssuesDataSource : PaginationDataSource<Issue, IssueCell> {
    
    required init(project: Project? = nil, searchQuery: String? = nil) {
        var params = [String: String]()
        if let query = searchQuery {
            params["filter"] = query
        }
        var resource = "issue/"
        if let projId = project?.id {
            resource = "issue/byproject/\(projId)"
        }
        let paginator = Paginator<Item>(resource: resource, query: params)
        super.init(paginator: paginator)
        CellIdentifier = R.nib.issueCell.reuseIdentifier.identifier
    }
    
    override func registerReusableViews(tableView: UITableView) {
        tableView.registerNib(
            R.nib.issueCell.instance,
            forCellReuseIdentifier: R.nib.issueCell.reuseIdentifier.identifier
        )
    }
    
}