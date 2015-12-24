//
//  APIClient.swift
//  Youtack
//
//  Created by Yarik Smirnov on 27/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Alamofire

class APIClient {
    
    let session: Session
    var router: Router?
    var currentRequest: Request?
    
    var entity: Object? {
        didSet {
            if entity != nil {
                entityID = (entity?.id)!
            }
        }
    }
    var entityID: String?
    
    required init(session: Session) {
        self.session = session
        if let host = session.host {
            self.router = Router(host: host)
        }
    }
    
    convenience init() {
        self.init(session: AppDelegate.instance.context.session)
    }
    
    convenience init(entityId: String) {
        self.init()
        self.entityID = entityId
    }
    
    convenience init(entity: Object) {
        self.init()
        self.entity = entity
    }
    
    func cancelRequest() {
        currentRequest?.cancel()
    }
    
}