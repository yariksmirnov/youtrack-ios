//
//  ProjectsManager.swift
//  Youtack
//
//  Created by Yarik Smirnov on 24/12/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Foundation


class ProjectsManager {
    
    private var projects = [Project]()
    private var projecstApi = ProjectsAPI()
    
    func getProjects(completion: ([Project], NSError?) -> Void) {
        projecstApi.getProjects { [unowned self] projects, error in
            self.projects = projects ?? []
            completion(self.projects, error)
        }
    }
    
}