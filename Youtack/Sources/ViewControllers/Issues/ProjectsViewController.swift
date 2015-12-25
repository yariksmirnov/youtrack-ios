//
//  ProjectsViewController.swift
//  Youtack
//
//  Created by Yarik Smirnov on 24/12/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//



class ProjectsViewController: ListViewController {
    
    var selectedProject: Observable<Project?> = Observable(nil)
    
    required init() {
        super.init(nibName: nil, bundle: nil)
        transitioningDelegate = self
        modalPresentationStyle = .OverCurrentContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.autoPinEdgesToSuperviewEdges()
        tableView.rowHeight = 48
        tableView.separatorStyle = .SingleLine
        tableView.separatorInset = UIEdgeInsetsZero
        automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func buildDataSource() -> DataSource? {
        return ProjectsDataSource(context: context)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedProject ^= dataSource?.dataSourceItem(indexPath) as? Project
    }
    
    func tableView(tableView: UITableView,
        willDisplayCell cell: UITableViewCell, 
        forRowAtIndexPath indexPath: NSIndexPath)
    {
        guard let project = dataSource?.dataSourceItem(indexPath) as? Project else {
            return
        }
        cell.accessoryType = selectedProject^ == project ? .Checkmark : .None
    }
}


extension ProjectsViewController: UIViewControllerTransitioningDelegate {
    
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


