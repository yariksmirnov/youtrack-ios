//
//  ProjectsAPI.swift
//  Youtack
//
//  Created by Yarik Smirnov on 24/12/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//


class ProjectsAPI: APIClient {
    
    func getProjects(completion: ([Project]?, NSError?) -> Void) {
        guard let url = router?.allProjects() else { return }
        currentRequest = request(.GET, url, parameters: [ "verbose" : true])
            .responseArray { (request, response, result: Result<[Project]>) in
                switch result {
                case .Success(let projects):
                    completion(projects, nil)
                case .Failure(_, _): break
                }
            }.responseError { error in
                completion(nil, error)
        }
    }

}
