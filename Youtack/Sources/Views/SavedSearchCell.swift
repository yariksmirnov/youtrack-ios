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

public class SavedSearchCell: MKTableViewCell, ConfigurableCell {
    
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
        rippleLayerColor = MaterialDesignColor.blue500
        contentView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        contentView.addSubview(nameTextLabel)
        nameTextLabel.font = R.font.robotoRegular(size: 16)
        nameTextLabel.autoPinEdgesToSuperviewMargins()
        
        contentView.addSubview(separatorView)
        separatorView.autoSetDimension(.Height, toSize: 1.0/UIScreen.mainScreen().scale)
        separatorView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero, excludingEdge: .Top)
        separatorView.backgroundColor = UIColor(gray: 240)
    }
    
    public func configure(item: SavedSearch) {
        nameTextLabel.text = item.name
    }
}
