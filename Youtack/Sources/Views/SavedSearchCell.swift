//
//  SavedSearchCell.swift
//  Youtack
//
//  Created by Yarik Smirnov on 03/11/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit

class SavedSearchCell: UITableViewCell {
    
    func configure(savedSearch: SavedSearch) {
        textLabel?.text = savedSearch.name
    }
    
}
