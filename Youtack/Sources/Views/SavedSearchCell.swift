//
//  SavedSearchCell.swift
//  Youtack
//
//  Created by Yarik Smirnov on 03/11/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit

public class SavedSearchCell: MaterialTableCell, ConfigurableCell {
    
    public func configure(item: SavedSearch) {
        textLabel?.text = item.name
    }
}
