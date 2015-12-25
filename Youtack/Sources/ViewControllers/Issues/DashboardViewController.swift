//
//  DashboardViewController.swift
//  Youtack
//
//  Created by Yarik Smirnov on 30/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit

class DashboardViewController: ListViewController, UITextFieldDelegate {
    
    var contextsTableView = UITableView()
    var contextsDataSource = SavedSearchesDataSource()
    var contextsAdapter: BasicAdapter!
    var expandableTitleView = ExpandableTitleView()
    @IBOutlet var searchBarContainer: UIView!
    @IBOutlet var searchField: UITextField!
    
    var selectedProject: Project?
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
        savedSearchesViewController.selectedContext += { [unowned self] old, new in
            self.dismissViewControllerAnimated(true) {
                self.searchField.text = new?.query ?? self.searchField.text
                self.updateDataSource()
            }
        }
        
        projectsViewController.attachDataSource()
        projectsViewController.dataSource?.loadContent(false)
        projectsViewController.selectedProject += { [unowned self] old, new in
            self.expandableTitleView.animateToArrowOrientation(.Down)
            self.dismissViewControllerAnimated(true) {
                if self.projectsViewController.selectedProject^ != self.selectedProject {
                    self.selectedProject = self.projectsViewController.selectedProject^
                    self.updateDataSource()
                    self.updateTitle()
                }
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        contextsDataSource.loadContent(false)
    }
    
    override func layoutTableView() {
        super.layoutTableView()
        automaticallyAdjustsScrollViewInsets = false
        tableView.keyboardDismissMode = .Interactive
        tableView.estimatedRowHeight = 88
        tableView.autoPinEdgesToSuperviewEdgesWithInsets(
            UIEdgeInsetsZero,
            excludingEdge: .Top)
        tableView.autoPinEdge(.Top, toEdge: .Bottom, ofView: searchBarContainer)
    }
    
    override func buildDataSource() -> DataSource? {
        return IssuesDataSource(project: selectedProject, searchQuery: searchField.text)
    }
    
    func updateDataSource() {
        resetDataSource()
        attachDataSource()
        dataSource?.loadContent(false)
    }
    
    //MARK: TextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        updateDataSource()
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: TableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let issue = issuesDataSource?.item(indexPath) {
            let issueVC = IssueViewController(issue: issue)
            navigationController?.pushViewController(issueVC, animated: true)
        }
    }
}
