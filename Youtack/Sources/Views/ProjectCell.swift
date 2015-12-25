//
//  ProjectCell.swift
//  Youtack
//
//  Created by Yarik Smirnov on 25/12/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//


class ProjectCell: UITableViewCell, ConfigurableCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutMargins = UIEdgeInsetsZero
        preservesSuperviewLayoutMargins = false
        selectionStyle = .None
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(item: Project) {
        
        textLabel?.text = item.name
    }
    
}
