//
//  SearchContextsViewController.swift
//  Youtack
//
//  Created by Yarik Smirnov on 19/12/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit

class SavedSearchesViewController: ListViewController {
    
    var selectedContext: Observable<SavedSearch?> = Observable(nil)
    
    required init() {
        super.init(nibName: nil, bundle: nil)
        transitioningDelegate = self
        modalPresentationStyle = .OverCurrentContext
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.autoPinEdgesToSuperviewEdges()
        tableView.rowHeight = 44
        automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    var searchContextsDataSource: SavedSearchesDataSource {
        get { return dataSource as! SavedSearchesDataSource }
    }
    
    override func buildDataSource() -> DataSource? {
        return SavedSearchesDataSource()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedContext ^= searchContextsDataSource.item(indexPath)
    }
    
    func tableView(tableView: UITableView,
        willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath)
    {
        if let search = searchContextsDataSource.item(indexPath) {
            if search == selectedContext^ {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
        }
    }
    
}

extension SavedSearchesViewController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, 
        presentingController presenting: UIViewController, 
        sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return DropDownListAnimator()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController)
        -> UIViewControllerAnimatedTransitioning?
    {
        return DropDownListAnimator(dismissing: true)
    }
    
    func presentationControllerForPresentedViewController(presented: UIViewController,
        presentingViewController presenting: UIViewController, 
        sourceViewController source: UIViewController) -> UIPresentationController?
    {
        return SFPrensetationController(
            presentedViewController: presented,
            presentingViewController: presenting
        )
    }
    
}

