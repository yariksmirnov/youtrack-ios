//
//  IssueViewController.swift
//  Youtack
//
//  Created by Yarik Smirnov on 21/12/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit

class IssueViewController: ListViewController {
    
    var issue: Issue
    
    var segmentedControl = UISegmentedControl()
    var header = UIView()
    
    required init(issue: Issue) {
        self.issue = issue
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.autoPinEdgesToSuperviewEdges()
        layoutSegmentedControl()
    }
    
    func layoutSegmentedControl() {
        header.addSubview(segmentedControl)
        segmentedControl.autoCenterInSuperview()
        segmentedControl.insertSegmentWithTitle("Commets", atIndex: 0, animated: false)
        segmentedControl.insertSegmentWithTitle("History", atIndex: 1, animated: false)
        segmentedControl.insertSegmentWithTitle("Time Tracking", atIndex: 2, animated: false)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
}
