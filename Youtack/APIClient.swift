//
//  APIClient.swift
//  Youtack
//
//  Created by Yarik Smirnov on 27/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Alamofire

public class APIClient {
    
    let session: Session!
    var currentRequest: Request? {
        didSet {
            if let request = currentRequest {
                print(request)
            }
        }
    }
    
    var entity: Object? {
        didSet {
            if entity != nil {
                entityID = (entity?.id)!
            }
        }
    }
    var entityID: Int?
    
    public init?() {
        self.session = Session.active
        if self.session == nil {
            return nil
        }
    }
    
    public init(session: Session, entity: Object) {
        self.session = session
        self.entity = entity
        self.entityID = entity.id
    }
    
    public init(session: Session, entityID: Int) {
        self.session = session
        self.entityID = entityID
    }
    
    convenience public init?(entity: Object) {
        guard let active = Session.active else {
            return nil
        }
        self.init(session: active, entity: entity)
    }
    
    convenience public init?(entityID: Int) {
        guard let active = Session.active else {
            return nil
        }
        self.init(session: active, entityID: entityID)
    }
    
    public func cancelRequest() {
        currentRequest?.cancel()
    }
    
}