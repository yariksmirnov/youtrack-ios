//
//  IssuesListViewController.swift
//  Youtack
//
//  Created by Yarik Smirnov on 06/11/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit
import MaterialDesignColor

class IssuesListViewController: ListViewController {

    var issuesDataSource: IssuesDataSource? {
        get { return dataSource as? IssuesDataSource }
    }
    var savedSearch: SavedSearch?
    
    init(savedSearch: SavedSearch) {
        self.savedSearch = savedSearch
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCustomNavigationBar()
        title = savedSearch?.query?.uppercaseString
    }
    
    override func layoutTableView() {
        super.layoutTableView()
        tableView.autoPinEdgesToSuperviewEdges()
        tableView.estimatedRowHeight = 88
    }
    
    override func buildDataSource() -> DataSource? {
        return IssuesDataSource(searchQuery: savedSearch!.query!)
    }
}
