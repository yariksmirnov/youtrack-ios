//
//  DashboardViewController.swift
//  Youtack
//
//  Created by Yarik Smirnov on 30/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit

class DashboardViewController: ListViewController {
    
    var contextsTableView = UITableView()
    var contextsDataSource = SavedSearchesDataSource()
    var contextsAdapter: BasicAdapter!
    var expandableTitleView = ExpandableTitleView()
    @IBOutlet var searchBarContainer: UIView!
    
    var selectedProject: Project?
    var savedSearch: SavedSearch?
    var savedSearchesViewController = SavedSearchesViewController()
    var projectsViewController = ProjectsViewController()
    
    var issuesDataSource: IssuesDataSource? {
        get { return dataSource as? IssuesDataSource }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutTitleView()
        definesPresentationContext = true
        
        savedSearchesViewController.attachDataSource()
        savedSearchesViewController.dataSource?.loadContent(false)
        savedSearchesViewController.selectedContext += { old, new in
            self.onSavedSearches()
        }
        
        projectsViewController.attachDataSource()
        projectsViewController.dataSource?.loadContent(false)
        projectsViewController.selectedProject += { old, new in
            self.onTitleView()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        contextsDataSource.loadContent(false)
    }
    
    override func layoutTableView() {
        super.layoutTableView()
        automaticallyAdjustsScrollViewInsets = false
        tableView.estimatedRowHeight = 88
        tableView.autoPinEdgesToSuperviewEdgesWithInsets(
            UIEdgeInsetsZero,
            excludingEdge: .Top)
        tableView.autoPinEdge(.Top, toEdge: .Bottom, ofView: searchBarContainer)
    }
    
    override func buildDataSource() -> DataSource? {
        return IssuesDataSource(project: selectedProject, searchQuery: savedSearch?.query)
    }
    
    func updateDataSource() {
        resetDataSource()
        attachDataSource()
        dataSource?.loadContent(false)
    }
    
    //MARK: TableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let issue = issuesDataSource?.item(indexPath) {
            let issueVC = IssueViewController(issue: issue)
            navigationController?.pushViewController(issueVC, animated: true)
        }
    }
}
