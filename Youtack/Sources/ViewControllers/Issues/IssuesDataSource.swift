//
//  IssuesDataSource.swift
//  Youtack
//
//  Created by Yarik Smirnov on 10/10/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit


class IssuesDataSource : PaginationDataSource<Issue, IssueCell> {
    
    required init() {
        let paginator = Paginator<Item>(resource: "issues/")
        super.init(paginator: paginator!)
        CellIdentifier = "IssueCell"
    }
    
}