//
//  ProjectsDataSource.swift
//  Youtack
//
//  Created by Yarik Smirnov on 24/12/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Foundation


class ProjectsDataSource: BasicDataSource<Project, ProjectCell> {

    var context: Context
    
    init(context: Context) {
        self.context = context
        super.init()
        CellIdentifier = "ProjectCell"
    }
    
    override func initializeLoader() {
        ContentLoader = { [weak self] completion in
            self?.context.projectsManager.getProjects { projects, error in
                completion { ds in
                    ds.items = projects
                    ds.notifyDidReloadData()
                    return error
                }
            }
        }
    }
    
}