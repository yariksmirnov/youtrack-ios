//
//  SavedSearches.swift
//  Youtack
//
//  Created by Yarik Smirnov on 19/12/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Foundation
import Observable

extension DashboardViewController {

    func layoutTitleView() {
        expandableTitleView.layoutIfNeeded()
        expandableTitleView.size = expandableTitleView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        expandableTitleView.titleButton.addTarget(self,
                action: "onTitleView",
                forControlEvents: .TouchUpInside
        )
        navigationItem.titleView = expandableTitleView
    }

    func onTitleView() {
        let projectsPresented = projectsViewController.presentingViewController != nil
        if !projectsPresented {
            expandableTitleView.animateToArrowOrientation(.Up)
            resignResponderAndWait {
                self.presentAfterDismiss(
                    self.projectsViewController,
                    viewControllerToDismiss: self.savedSearchesViewController)
            }
        } else {
            expandableTitleView.animateToArrowOrientation(.Down)
            dismissViewControllerAnimated(true, completion:  nil)
        }
    }
    
    func updateTitle() {
        navigationItem.titleView = nil
        expandableTitleView.label.text = selectedProject?.name
        expandableTitleView.layoutIfNeeded()
        expandableTitleView.size = expandableTitleView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        navigationItem.titleView = expandableTitleView
    }
    
    @IBAction func onSavedSearches() {
        let contextsPreseneted = savedSearchesViewController.presentingViewController != nil
        if !contextsPreseneted {
            expandableTitleView.animateToArrowOrientation(.Down)
            resignResponderAndWait {
                self.presentAfterDismiss(
                    self.savedSearchesViewController,
                    viewControllerToDismiss: self.projectsViewController)
            }
        } else {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
}