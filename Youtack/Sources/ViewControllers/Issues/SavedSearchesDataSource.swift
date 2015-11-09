//
//  SavedSearchesDataSource.swift
//  Youtack
//
//  Created by Yarik Smirnov on 31/10/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit


public class SavedSearchesDataSource : PaginationDataSource<SavedSearch, SavedSearchCell> {
    
    init() {
        let paginator = Paginator<SavedSearch>(resource: "user/search")
        super.init(paginator: paginator!)
        CellIdentifier = "SavedSearchCell"
    }
    
}