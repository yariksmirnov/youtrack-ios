//
//  ProjectCell.swift
//  Youtack
//
//  Created by Yarik Smirnov on 25/12/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//


class ProjectCell: UITableViewCell, ConfigurableCell {

    func configure(item: Project) {
        textLabel?.text = item.name
    }
    
}
