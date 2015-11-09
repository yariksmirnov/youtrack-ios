//
//  IssueCell.swift
//  Youtack
//
//  Created by Yarik Smirnov on 10/10/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit
import MaterialKit

public class IssueCell: MKTableViewCell, ConfigurableCell {
    
    @IBOutlet var summaryLabel: UILabel?
    @IBOutlet var numberLabel: UILabel?

    public func configure(item: Issue) {
        summaryLabel?.text = item.summary
        numberLabel?.text = item.id
    }
}
