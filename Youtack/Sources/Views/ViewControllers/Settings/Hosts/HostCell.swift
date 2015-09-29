//
//  HostCell.swift
//  Youtack
//
//  Created by Yarik Smirnov on 24/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit

class HostCell: UITableViewCell {
    
    func configure(host: Host) {
        textLabel?.text = host.title
    }
}
