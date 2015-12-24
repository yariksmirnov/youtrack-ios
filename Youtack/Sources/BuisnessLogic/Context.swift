//
//  Context.swift
//  Youtack
//
//  Created by Yarik Smirnov on 19/12/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Foundation


protocol Context {
    var session: Session { get }
    var projectsManager: ProjectsManager { get }
}

class AppContext: Context {
    private(set) lazy var session = { return Session() }()
    private(set) lazy var projectsManager = { return ProjectsManager() }()
}