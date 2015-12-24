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
            presentAfterResign(projectsViewController, animated: true, completion: nil)
        } else {
            expandableTitleView.animateToArrowOrientation(.Down)
            dismissViewControllerAnimated(true) {
                if self.projectsViewController.selectedProject^ != self.selectedProject {
                    self.selectedProject = self.projectsViewController.selectedProject^
                    self.updateDataSource()
                    self.updateTitle()
                }
            }
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
            expandableTitleView.animateToArrowOrientation(.Up)
            presentAfterResign(savedSearchesViewController, animated: true, completion: nil)
        } else {
            expandableTitleView.animateToArrowOrientation(.Down)
            dismissViewControllerAnimated(true) {
                if self.savedSearchesViewController.selectedContext^ != self.savedSearch {
                    self.savedSearch = self.savedSearchesViewController.selectedContext^
                    self.updateDataSource()
                }
            }
        }
    }
}