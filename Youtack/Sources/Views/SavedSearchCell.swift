//
//  SavedSearchCell.swift
//  Youtack
//
//  Created by Yarik Smirnov on 03/11/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit
import MaterialKit
import MaterialDesignColor

public class SavedSearchCell: UITableViewCell, ConfigurableCell {
    
    var nameTextLabel = UILabel()
    var separatorView = UIView()
    
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        defaultInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultInit()
    }
    
    func defaultInit() {
        selectionStyle = .None
        contentView.addSubview(separatorView)
        separatorView.autoSetDimension(.Height, toSize: 1.0)
        separatorView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero, excludingEdge: .Top)
        separatorView.backgroundColor = UIColor(gray: 240)
    }
    
    public func configure(item: SavedSearch) {
        textLabel?.text = item.name
    }
}
